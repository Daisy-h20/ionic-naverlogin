export interface naverLoginPlugin {
    naverLogin(options: {
        serviceUrlScheme: string;
        naverClientId: string;
        naverClientSecret: string;
        naverClientName: string;
    }): Promise<{
        email: string;
    }>;
}
