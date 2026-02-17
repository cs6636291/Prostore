/*
  Warnings:

  - You are about to drop the column `shipping` on the `Cart` table. All the data in the column will be lost.
  - The primary key for the `Session` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - Added the required column `shippingPrice` to the `Cart` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Made the column `email` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "Session_sessionToken_key";

-- AlterTable
ALTER TABLE "Account" ADD CONSTRAINT "Account_pkey" PRIMARY KEY ("provider", "providerAccountId");

-- DropIndex
DROP INDEX "Account_provider_providerAccountId_key";

-- AlterTable
ALTER TABLE "Cart" DROP COLUMN "shipping",
ADD COLUMN     "shippingPrice" DECIMAL(12,2) NOT NULL;

-- AlterTable
ALTER TABLE "Product" ALTER COLUMN "isFeatured" SET DEFAULT false;

-- AlterTable
ALTER TABLE "Session" DROP CONSTRAINT "Session_pkey",
ALTER COLUMN "sessionToken" SET DATA TYPE TEXT,
ADD CONSTRAINT "Session_pkey" PRIMARY KEY ("sessionToken");

-- AlterTable
ALTER TABLE "User" ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "email" SET NOT NULL;

-- AlterTable
ALTER TABLE "VerificationToken" ADD CONSTRAINT "VerificationToken_pkey" PRIMARY KEY ("identifier", "token");

-- DropIndex
DROP INDEX "VerificationToken_identifier_token_key";
