import { WebPlugin } from '@capacitor/core';
import type { naverLoginPlugin } from './definitions';
export declare class naverLoginWeb extends WebPlugin implements naverLoginPlugin {
    naverLogin(_options: {
        serviceUrlScheme: string;
        naverClientId: string;
        naverClientSecret: string;
        naverClientName: string;
    }): Promise<{
        email: string;
    }>;
}
