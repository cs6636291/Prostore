import {z} from 'zod';
import { insertProductSchhema } from '@/lib/validators';
export type Product = z.infer<typeof insertProductSchhema>& {
    id: string;
    rating: string;
    createdAt: Date

};