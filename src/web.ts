import { WebPlugin } from '@capacitor/core';

import type { naverLoginPlugin } from './definitions';

export class naverLoginWeb extends WebPlugin implements naverLoginPlugin {
  naverLogin(_options: {
    serviceUrlScheme: string;
    naverClientId: string;
    naverClientSecret: string;
    naverClientName: string;
  }): Promise<{ email: string }> {
    throw new Error('Method not implemented.');
  }
}
