'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const naverLogin = core.registerPlugin('naverLogin', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.naverLoginWeb()),
});

class naverLoginWeb extends core.WebPlugin {
    naverLogin(_options) {
        throw new Error('Method not implemented.');
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    naverLoginWeb: naverLoginWeb
});

exports.naverLogin = naverLogin;
//# sourceMappingURL=plugin.cjs.js.map
