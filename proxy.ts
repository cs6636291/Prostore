import { auth } from "@/auth";
import { NextResponse } from "next/server";

export const proxy = auth((req) => {
  //Array of regexpatterns of paths we want to protect
  const protectedPaths = [
    /\/shipping-address/,
    /\/payment-method/,
    /\/place-order/,
    /\/profile/,
    /\/user\/(.*)/,
    /\/order\/(.*)/,
    /\/admin/,
  ];
  // Get pathname from the req URL object
  const { pathname } = req.nextUrl;

  // Check if user is not authenticated and accessing a protected path
  if (!req.auth && protectedPaths.some((p) => p.test(pathname)))
    return Response.redirect(new URL("/sign-in", req.url));

  // 1. ตรวจสอบว่ามี sessionCartId หรือยัง
  const hasCartId = req.cookies.has("sessionCartId");

  // 2. ถ้ามีอยู่แล้ว ให้ NextAuth จัดการเรื่อง Authorization ตามปกติ
  if (hasCartId) {
    return; // หรือ return NextResponse.next()
  }

  // 3. ถ้ายังไม่มี ให้สร้างใหม่และฝังลงใน Response
  const sessionCartId = crypto.randomUUID();
  const response = NextResponse.next();

  response.cookies.set("sessionCartId", sessionCartId, {
    path: "/",
    httpOnly: true,
    sameSite: "lax",
    maxAge: 60 * 60 * 24 * 30, // 30 วัน
  });

  return response;
});

export const config = {
  matcher: ["/((?!api|_next/static|_next/image|favicon.ico).*)"],
};
