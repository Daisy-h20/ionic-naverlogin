var capacitornaverLogin = (function (exports, core) {
    'use strict';

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

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
