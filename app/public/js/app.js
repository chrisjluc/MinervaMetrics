/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/js/";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var _reactRouter = __webpack_require__(2);
	
	var _history = __webpack_require__(3);
	
	var _reactDom = __webpack_require__(4);
	
	var _routes = __webpack_require__(5);
	
	var _routes2 = _interopRequireDefault(_routes);
	
	(0, _reactDom.render)(_react2['default'].createElement(
	    _reactRouter.Router,
	    { history: (0, _history.createHistory)() },
	    _routes2['default']
	), document.querySelectorAll('[data-ui-role="content"]')[0]);

/***/ },
/* 1 */
/***/ function(module, exports) {

	module.exports = React;

/***/ },
/* 2 */
/***/ function(module, exports) {

	module.exports = ReactRouter;

/***/ },
/* 3 */
/***/ function(module, exports) {

	module.exports = History;

/***/ },
/* 4 */
/***/ function(module, exports) {

	module.exports = ReactDOM;

/***/ },
/* 5 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';
	
	Object.defineProperty(exports, '__esModule', {
	    value: true
	});
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var _reactRouter = __webpack_require__(2);
	
	var _componentsApp = __webpack_require__(6);
	
	var _componentsApp2 = _interopRequireDefault(_componentsApp);
	
	var _componentsCommonNoMatch = __webpack_require__(8);
	
	var _componentsCommonNoMatch2 = _interopRequireDefault(_componentsCommonNoMatch);
	
	var _componentsDashboardDashboard = __webpack_require__(9);
	
	var _componentsDashboardDashboard2 = _interopRequireDefault(_componentsDashboardDashboard);
	
	var _componentsBillLatestBills = __webpack_require__(10);
	
	var _componentsBillLatestBills2 = _interopRequireDefault(_componentsBillLatestBills);
	
	exports['default'] = _react2['default'].createElement(
	    _reactRouter.Route,
	    { path: '/', component: _componentsApp2['default'] },
	    _react2['default'].createElement(
	        _reactRouter.Route,
	        { component: _componentsDashboardDashboard2['default'] },
	        _react2['default'].createElement(_reactRouter.IndexRoute, { component: _componentsBillLatestBills2['default'] })
	    ),
	    _react2['default'].createElement(_reactRouter.Route, { path: '*', component: _componentsCommonNoMatch2['default'] })
	);
	module.exports = exports['default'];

/***/ },
/* 6 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';
	
	Object.defineProperty(exports, '__esModule', {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ('value' in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ('value' in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError('Cannot call a class as a function'); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== 'function' && superClass !== null) { throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var _mainHeader = __webpack_require__(7);
	
	var _mainHeader2 = _interopRequireDefault(_mainHeader);
	
	var App = (function (_React$Component) {
	    _inherits(App, _React$Component);
	
	    function App() {
	        _classCallCheck(this, App);
	
	        _get(Object.getPrototypeOf(App.prototype), 'constructor', this).apply(this, arguments);
	    }
	
	    _createClass(App, [{
	        key: 'render',
	        value: function render() {
	            return _react2['default'].createElement(
	                'div',
	                null,
	                _react2['default'].createElement(_mainHeader2['default'], { root: this.props.route.path }),
	                this.props.children
	            );
	        }
	    }]);
	
	    return App;
	})(_react2['default'].Component);
	
	exports['default'] = App;
	module.exports = exports['default'];

/***/ },
/* 7 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';
	
	Object.defineProperty(exports, '__esModule', {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ('value' in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ('value' in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError('Cannot call a class as a function'); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== 'function' && superClass !== null) { throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var _reactRouter = __webpack_require__(2);
	
	var Header = (function (_React$Component) {
	    _inherits(Header, _React$Component);
	
	    function Header() {
	        _classCallCheck(this, Header);
	
	        _get(Object.getPrototypeOf(Header.prototype), 'constructor', this).apply(this, arguments);
	    }
	
	    _createClass(Header, [{
	        key: 'render',
	        value: function render() {
	            return _react2['default'].createElement(
	                'header',
	                { className: 'app-header' },
	                _react2['default'].createElement(
	                    'h1',
	                    { className: 'title' },
	                    _react2['default'].createElement(
	                        _reactRouter.IndexLink,
	                        { to: this.props.root },
	                        'App'
	                    )
	                )
	            );
	        }
	    }]);
	
	    return Header;
	})(_react2['default'].Component);
	
	exports['default'] = Header;
	module.exports = exports['default'];

/***/ },
/* 8 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";
	
	Object.defineProperty(exports, "__esModule", {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var NoMatch = (function (_React$Component) {
	    _inherits(NoMatch, _React$Component);
	
	    function NoMatch() {
	        _classCallCheck(this, NoMatch);
	
	        _get(Object.getPrototypeOf(NoMatch.prototype), "constructor", this).apply(this, arguments);
	    }
	
	    _createClass(NoMatch, [{
	        key: "render",
	        value: function render() {
	            return _react2["default"].createElement(
	                "section",
	                { className: "app-content" },
	                _react2["default"].createElement(
	                    "header",
	                    { className: "section-header" },
	                    _react2["default"].createElement(
	                        "h3",
	                        { className: "title" },
	                        "Not Found"
	                    )
	                )
	            );
	        }
	    }]);
	
	    return NoMatch;
	})(_react2["default"].Component);
	
	exports["default"] = NoMatch;
	module.exports = exports["default"];

/***/ },
/* 9 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";
	
	Object.defineProperty(exports, "__esModule", {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var Dashboard = (function (_React$Component) {
	    _inherits(Dashboard, _React$Component);
	
	    function Dashboard() {
	        _classCallCheck(this, Dashboard);
	
	        _get(Object.getPrototypeOf(Dashboard.prototype), "constructor", this).apply(this, arguments);
	    }
	
	    _createClass(Dashboard, [{
	        key: "render",
	        value: function render() {
	            return _react2["default"].createElement(
	                "main",
	                { className: "app-content dashboard" },
	                this.props.children
	            );
	        }
	    }]);
	
	    return Dashboard;
	})(_react2["default"].Component);
	
	exports["default"] = Dashboard;
	module.exports = exports["default"];

/***/ },
/* 10 */
/***/ function(module, exports, __webpack_require__) {

	'use strict';
	
	Object.defineProperty(exports, '__esModule', {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ('value' in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ('value' in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { 'default': obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError('Cannot call a class as a function'); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== 'function' && superClass !== null) { throw new TypeError('Super expression must either be null or a function, not ' + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var _commonList = __webpack_require__(11);
	
	var _commonList2 = _interopRequireDefault(_commonList);
	
	var _CompactBill = __webpack_require__(12);
	
	var _CompactBill2 = _interopRequireDefault(_CompactBill);
	
	var LatestBills = (function (_React$Component) {
	    _inherits(LatestBills, _React$Component);
	
	    function LatestBills(props) {
	        _classCallCheck(this, LatestBills);
	
	        _get(Object.getPrototypeOf(LatestBills.prototype), 'constructor', this).call(this, props);
	        this.state = { items: [] };
	    }
	
	    _createClass(LatestBills, [{
	        key: 'render',
	        value: function render() {
	            return _react2['default'].createElement(
	                'section',
	                { className: 'latest-bills' },
	                _react2['default'].createElement(
	                    'header',
	                    { className: 'section-header' },
	                    _react2['default'].createElement(
	                        'h3',
	                        { className: 'title' },
	                        'Latest Bills'
	                    )
	                ),
	                _react2['default'].createElement(
	                    'section',
	                    { className: 'section-content' },
	                    _react2['default'].createElement(_commonList2['default'], { items: this.state.items, itemType: _CompactBill2['default'] })
	                )
	            );
	        }
	    }, {
	        key: 'componentDidMount',
	        value: function componentDidMount() {
	            var _this = this;
	
	            fetch('/api/latest-bills').then(function (response) {
	                return response.json();
	            }).then(function (data) {
	                _this.setState({ items: data.items });
	            })['catch'](function (err) {
	                throw new Error(err);
	            });
	        }
	    }]);
	
	    return LatestBills;
	})(_react2['default'].Component);
	
	exports['default'] = LatestBills;
	module.exports = exports['default'];

/***/ },
/* 11 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";
	
	Object.defineProperty(exports, "__esModule", {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var List = (function (_React$Component) {
	    _inherits(List, _React$Component);
	
	    function List() {
	        _classCallCheck(this, List);
	
	        _get(Object.getPrototypeOf(List.prototype), "constructor", this).apply(this, arguments);
	    }
	
	    _createClass(List, [{
	        key: "render",
	        value: function render() {
	            var ItemType = this.props.itemType;
	            var items = this.props.items || [];
	            var markupItems = this.createItemsMarkup(items, ItemType);
	
	            return _react2["default"].createElement(
	                "ul",
	                { className: "ui-list" },
	                markupItems
	            );
	        }
	    }, {
	        key: "createItemsMarkup",
	        value: function createItemsMarkup(items, Type) {
	            var markupItems = items.map(function (item) {
	                return _react2["default"].createElement(
	                    "li",
	                    { className: "ui-list-item", key: item.id },
	                    _react2["default"].createElement(Type, { data: item })
	                );
	            });
	
	            return markupItems;
	        }
	    }]);
	
	    return List;
	})(_react2["default"].Component);
	
	exports["default"] = List;
	module.exports = exports["default"];

/***/ },
/* 12 */
/***/ function(module, exports, __webpack_require__) {

	"use strict";
	
	Object.defineProperty(exports, "__esModule", {
	    value: true
	});
	
	var _createClass = (function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; })();
	
	var _get = function get(_x, _x2, _x3) { var _again = true; _function: while (_again) { var object = _x, property = _x2, receiver = _x3; _again = false; if (object === null) object = Function.prototype; var desc = Object.getOwnPropertyDescriptor(object, property); if (desc === undefined) { var parent = Object.getPrototypeOf(object); if (parent === null) { return undefined; } else { _x = parent; _x2 = property; _x3 = receiver; _again = true; desc = parent = undefined; continue _function; } } else if ("value" in desc) { return desc.value; } else { var getter = desc.get; if (getter === undefined) { return undefined; } return getter.call(receiver); } } };
	
	function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { "default": obj }; }
	
	function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }
	
	function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }
	
	var _react = __webpack_require__(1);
	
	var _react2 = _interopRequireDefault(_react);
	
	var CompactBill = (function (_React$Component) {
	    _inherits(CompactBill, _React$Component);
	
	    function CompactBill() {
	        _classCallCheck(this, CompactBill);
	
	        _get(Object.getPrototypeOf(CompactBill.prototype), "constructor", this).apply(this, arguments);
	    }
	
	    _createClass(CompactBill, [{
	        key: "render",
	        value: function render() {
	            var data = this.props.data;
	            var amount = "$" + data.amount;
	
	            return _react2["default"].createElement(
	                "div",
	                { className: "bill compact-bill" },
	                _react2["default"].createElement("img", { className: "icon", src: data.icon }),
	                _react2["default"].createElement(
	                    "div",
	                    { className: "info-container" },
	                    _react2["default"].createElement(
	                        "h4",
	                        { className: "title" },
	                        data.vendor
	                    ),
	                    _react2["default"].createElement(
	                        "span",
	                        { className: "period" },
	                        data.period
	                    )
	                ),
	                _react2["default"].createElement(
	                    "span",
	                    { className: "amount" },
	                    amount
	                )
	            );
	        }
	    }]);
	
	    return CompactBill;
	})(_react2["default"].Component);
	
	exports["default"] = CompactBill;
	module.exports = exports["default"];

/***/ }
/******/ ]);
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIndlYnBhY2s6Ly8vd2VicGFjay9ib290c3RyYXAgODU4Yzk1Y2I5MTBhYzMyMWU4MDYiLCJ3ZWJwYWNrOi8vLy4vYXBwL2NsaWVudC5qcyIsIndlYnBhY2s6Ly8vZXh0ZXJuYWwgXCJSZWFjdFwiIiwid2VicGFjazovLy9leHRlcm5hbCBcIlJlYWN0Um91dGVyXCIiLCJ3ZWJwYWNrOi8vL2V4dGVybmFsIFwiSGlzdG9yeVwiIiwid2VicGFjazovLy9leHRlcm5hbCBcIlJlYWN0RE9NXCIiLCJ3ZWJwYWNrOi8vLy4vYXBwL3JvdXRlcy5qcyIsIndlYnBhY2s6Ly8vLi9hcHAvY29tcG9uZW50cy9hcHAuanMiLCJ3ZWJwYWNrOi8vLy4vYXBwL2NvbXBvbmVudHMvbWFpbi9IZWFkZXIuanMiLCJ3ZWJwYWNrOi8vLy4vYXBwL2NvbXBvbmVudHMvY29tbW9uL05vTWF0Y2guanMiLCJ3ZWJwYWNrOi8vLy4vYXBwL2NvbXBvbmVudHMvZGFzaGJvYXJkL0Rhc2hib2FyZC5qcyIsIndlYnBhY2s6Ly8vLi9hcHAvY29tcG9uZW50cy9iaWxsL0xhdGVzdEJpbGxzLmpzIiwid2VicGFjazovLy8uL2FwcC9jb21wb25lbnRzL2NvbW1vbi9MaXN0LmpzIiwid2VicGFjazovLy8uL2FwcC9jb21wb25lbnRzL2JpbGwvQ29tcGFjdEJpbGwuanMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IjtBQUFBO0FBQ0E7O0FBRUE7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7O0FBRUE7QUFDQTtBQUNBLHVCQUFlO0FBQ2Y7QUFDQTtBQUNBOztBQUVBO0FBQ0E7O0FBRUE7QUFDQTs7QUFFQTtBQUNBO0FBQ0E7OztBQUdBO0FBQ0E7O0FBRUE7QUFDQTs7QUFFQTtBQUNBOztBQUVBO0FBQ0E7Ozs7Ozs7Ozs7O2tDQ3RDa0IsQ0FBTzs7Ozt3Q0FDSixDQUFjOztvQ0FDUCxDQUFTOztxQ0FDaEIsQ0FBVzs7bUNBRWIsQ0FBVTs7OztBQUU3Qix1QkFDSTs7T0FBUSxPQUFPLEVBQUUsNkJBQWdCOztFQUV4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OlsiIFx0Ly8gVGhlIG1vZHVsZSBjYWNoZVxuIFx0dmFyIGluc3RhbGxlZE1vZHVsZXMgPSB7fTtcblxuIFx0Ly8gVGhlIHJlcXVpcmUgZnVuY3Rpb25cbiBcdGZ1bmN0aW9uIF9fd2VicGFja19yZXF1aXJlX18obW9kdWxlSWQpIHtcblxuIFx0XHQvLyBDaGVjayBpZiBtb2R1bGUgaXMgaW4gY2FjaGVcbiBcdFx0aWYoaW5zdGFsbGVkTW9kdWxlc1ttb2R1bGVJZF0pXG4gXHRcdFx0cmV0dXJuIGluc3RhbGxlZE1vZHVsZXNbbW9kdWxlSWRdLmV4cG9ydHM7XG5cbiBcdFx0Ly8gQ3JlYXRlIGEgbmV3IG1vZHVsZSAoYW5kIHB1dCBpdCBpbnRvIHRoZSBjYWNoZSlcbiBcdFx0dmFyIG1vZHVsZSA9IGluc3RhbGxlZE1vZHVsZXNbbW9kdWxlSWRdID0ge1xuIFx0XHRcdGV4cG9ydHM6IHt9LFxuIFx0XHRcdGlkOiBtb2R1bGVJZCxcbiBcdFx0XHRsb2FkZWQ6IGZhbHNlXG4gXHRcdH07XG5cbiBcdFx0Ly8gRXhlY3V0ZSB0aGUgbW9kdWxlIGZ1bmN0aW9uXG4gXHRcdG1vZHVsZXNbbW9kdWxlSWRdLmNhbGwobW9kdWxlLmV4cG9ydHMsIG1vZHVsZSwgbW9kdWxlLmV4cG9ydHMsIF9fd2VicGFja19yZXF1aXJlX18pO1xuXG4gXHRcdC8vIEZsYWcgdGhlIG1vZHVsZSBhcyBsb2FkZWRcbiBcdFx0bW9kdWxlLmxvYWRlZCA9IHRydWU7XG5cbiBcdFx0Ly8gUmV0dXJuIHRoZSBleHBvcnRzIG9mIHRoZSBtb2R1bGVcbiBcdFx0cmV0dXJuIG1vZHVsZS5leHBvcnRzO1xuIFx0fVxuXG5cbiBcdC8vIGV4cG9zZSB0aGUgbW9kdWxlcyBvYmplY3QgKF9fd2VicGFja19tb2R1bGVzX18pXG4gXHRfX3dlYnBhY2tfcmVxdWlyZV9fLm0gPSBtb2R1bGVzO1xuXG4gXHQvLyBleHBvc2UgdGhlIG1vZHVsZSBjYWNoZVxuIFx0X193ZWJwYWNrX3JlcXVpcmVfXy5jID0gaW5zdGFsbGVkTW9kdWxlcztcblxuIFx0Ly8gX193ZWJwYWNrX3B1YmxpY19wYXRoX19cbiBcdF9fd2VicGFja19yZXF1aXJlX18ucCA9IFwiL2pzL1wiO1xuXG4gXHQvLyBMb2FkIGVudHJ5IG1vZHVsZSBhbmQgcmV0dXJuIGV4cG9ydHNcbiBcdHJldHVybiBfX3dlYnBhY2tfcmVxdWlyZV9fKDApO1xuXG5cblxuLyoqIFdFQlBBQ0sgRk9PVEVSICoqXG4gKiogd2VicGFjay9ib290c3RyYXAgODU4Yzk1Y2I5MTBhYzMyMWU4MDZcbiAqKi8iLCJpbXBvcnQgUmVhY3QgZnJvbSAncmVhY3QnO1xuaW1wb3J0IHtSb3V0ZXJ9IGZyb20gJ3JlYWN0LXJvdXRlcic7XG5pbXBvcnQge2NyZWF0ZUhpc3Rvcnl9IGZyb20gJ2hpc3RvcnknO1xuaW1wb3J0IHtyZW5kZXJ9IGZyb20gJ3JlYWN0LWRvbSc7XG5cbmltcG9ydCByb3V0ZXMgZnJvbSAnLi9yb3V0ZXMnO1xuXG5yZW5kZXIoKFxuICAgIDxSb3V0ZXIgaGlzdG9yeT17Y3JlYXRlSGlzdG9yeSgpfT5cbiAgICAgICAge3JvdXRlc31cbiAgICA8L1JvdXRlcj5cbiksIGRvY3VtZW50LnF1ZXJ5U2VsZWN0b3JBbGwoJ1tkYXRhLXVpLXJvbGU9XCJjb250ZW50XCJdJylbMF0pO1xuXG5cblxuLyoqIFdFQlBBQ0sgRk9PVEVSICoqXG4gKiogLi9hcHAvY2xpZW50LmpzXG4gKiovIiwibW9kdWxlLmV4cG9ydHMgPSBSZWFjdDtcblxuXG4vKioqKioqKioqKioqKioqKipcbiAqKiBXRUJQQUNLIEZPT1RFUlxuICoqIGV4dGVybmFsIFwiUmVhY3RcIlxuICoqIG1vZHVsZSBpZCA9IDFcbiAqKiBtb2R1bGUgY2h1bmtzID0gMFxuICoqLyIsIm1vZHVsZS5leHBvcnRzID0gUmVhY3RSb3V0ZXI7XG5cblxuLyoqKioqKioqKioqKioqKioqXG4gKiogV0VCUEFDSyBGT09URVJcbiAqKiBleHRlcm5hbCBcIlJlYWN0Um91dGVyXCJcbiAqKiBtb2R1bGUgaWQgPSAyXG4gKiogbW9kdWxlIGNodW5rcyA9IDBcbiAqKi8iLCJtb2R1bGUuZXhwb3J0cyA9IEhpc3Rvcnk7XG5cblxuLyoqKioqKioqKioqKioqKioqXG4gKiogV0VCUEFDSyBGT09URVJcbiAqKiBleHRlcm5hbCBcIkhpc3RvcnlcIlxuICoqIG1vZHVsZSBpZCA9IDNcbiAqKiBtb2R1bGUgY2h1bmtzID0gMFxuICoqLyIsIm1vZHVsZS5leHBvcnRzID0gUmVhY3RET007XG5cblxuLyoqKioqKioqKioqKioqKioqXG4gKiogV0VCUEFDSyBGT09URVJcbiAqKiBleHRlcm5hbCBcIlJlYWN0RE9NXCJcbiAqKiBtb2R1bGUgaWQgPSA0XG4gKiogbW9kdWxlIGNodW5rcyA9IDBcbiAqKi8iLCJpbXBvcnQgUmVhY3QgZnJvbSAncmVhY3QnO1xuaW1wb3J0IHtJbmRleFJvdXRlLCBSb3V0ZX0gZnJvbSAncmVhY3Qtcm91dGVyJztcblxuaW1wb3J0IEFwcCBmcm9tICcuL2NvbXBvbmVudHMvYXBwJztcbmltcG9ydCBOb01hdGNoIGZyb20gJy4vY29tcG9uZW50cy9jb21tb24vTm9NYXRjaCc7XG5cbmltcG9ydCBEYXNoYm9hcmQgZnJvbSAnLi9jb21wb25lbnRzL2Rhc2hib2FyZC9EYXNoYm9hcmQnO1xuaW1wb3J0IExhdGVzdEJpbGxzIGZyb20gJy4vY29tcG9uZW50cy9iaWxsL0xhdGVzdEJpbGxzJztcblxuZXhwb3J0IGRlZmF1bHQgKFxuICAgIDxSb3V0ZSBwYXRoPVwiL1wiIGNvbXBvbmVudD17QXBwfT5cbiAgICAgICAgPFJvdXRlIGNvbXBvbmVudD17RGFzaGJvYXJkfT5cbiAgICAgICAgICAgIDxJbmRleFJvdXRlIGNvbXBvbmVudD17TGF0ZXN0QmlsbHN9Lz5cbiAgICAgICAgPC9Sb3V0ZT5cbiAgICAgICAgPFJvdXRlIHBhdGg9XCIqXCIgY29tcG9uZW50PXtOb01hdGNofS8+XG4gICAgPC9Sb3V0ZT5cbik7XG5cblxuXG4vKiogV0VCUEFDSyBGT09URVIgKipcbiAqKiAuL2FwcC9yb3V0ZXMuanNcbiAqKi8iLCJpbXBvcnQgUmVhY3QgZnJvbSAncmVhY3QnO1xuXG5pbXBvcnQgSGVhZGVyIGZyb20gJy4vbWFpbi9IZWFkZXInO1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBBcHAgZXh0ZW5kcyBSZWFjdC5Db21wb25lbnQge1xuICAgIHJlbmRlcigpIHtcbiAgICAgICAgcmV0dXJuIChcbiAgICAgICAgICAgIDxkaXY+XG4gICAgICAgICAgICAgICAgPEhlYWRlciByb290PXt0aGlzLnByb3BzLnJvdXRlLnBhdGh9Lz5cbiAgICAgICAgICAgICAgICB7dGhpcy5wcm9wcy5jaGlsZHJlbn1cbiAgICAgICAgICAgIDwvZGl2PlxuICAgICAgICApO1xuICAgIH1cbn1cblxuXG5cbi8qKiBXRUJQQUNLIEZPT1RFUiAqKlxuICoqIC4vYXBwL2NvbXBvbmVudHMvYXBwLmpzXG4gKiovIiwiaW1wb3J0IFJlYWN0IGZyb20gJ3JlYWN0JztcbmltcG9ydCB7SW5kZXhMaW5rfSBmcm9tICdyZWFjdC1yb3V0ZXInO1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBIZWFkZXIgZXh0ZW5kcyBSZWFjdC5Db21wb25lbnQge1xuICAgIHJlbmRlcigpIHtcbiAgICAgICAgcmV0dXJuIChcbiAgICAgICAgICAgIDxoZWFkZXIgY2xhc3NOYW1lPVwiYXBwLWhlYWRlclwiPlxuICAgICAgICAgICAgICAgIDxoMSBjbGFzc05hbWU9XCJ0aXRsZVwiPlxuICAgICAgICAgICAgICAgICAgICA8SW5kZXhMaW5rIHRvPXt0aGlzLnByb3BzLnJvb3R9PkFwcDwvSW5kZXhMaW5rPlxuICAgICAgICAgICAgICAgIDwvaDE+XG4gICAgICAgICAgICA8L2hlYWRlcj5cbiAgICAgICAgKTtcbiAgICB9XG59XG5cblxuXG4vKiogV0VCUEFDSyBGT09URVIgKipcbiAqKiAuL2FwcC9jb21wb25lbnRzL21haW4vSGVhZGVyLmpzXG4gKiovIiwiaW1wb3J0IFJlYWN0IGZyb20gJ3JlYWN0JztcblxuZXhwb3J0IGRlZmF1bHQgY2xhc3MgTm9NYXRjaCBleHRlbmRzIFJlYWN0LkNvbXBvbmVudCB7XG4gICAgcmVuZGVyKCkge1xuICAgICAgICByZXR1cm4gKFxuICAgICAgICAgICAgPHNlY3Rpb24gY2xhc3NOYW1lPVwiYXBwLWNvbnRlbnRcIj5cbiAgICAgICAgICAgICAgICA8aGVhZGVyIGNsYXNzTmFtZT1cInNlY3Rpb24taGVhZGVyXCI+XG4gICAgICAgICAgICAgICAgICAgIDxoMyBjbGFzc05hbWU9XCJ0aXRsZVwiPk5vdCBGb3VuZDwvaDM+XG4gICAgICAgICAgICAgICAgPC9oZWFkZXI+XG4gICAgICAgICAgICA8L3NlY3Rpb24+XG4gICAgICAgICk7XG4gICAgfVxufVxuXG5cblxuLyoqIFdFQlBBQ0sgRk9PVEVSICoqXG4gKiogLi9hcHAvY29tcG9uZW50cy9jb21tb24vTm9NYXRjaC5qc1xuICoqLyIsImltcG9ydCBSZWFjdCBmcm9tICdyZWFjdCc7XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIERhc2hib2FyZCBleHRlbmRzIFJlYWN0LkNvbXBvbmVudCB7XG4gICAgcmVuZGVyKCkge1xuICAgICAgICByZXR1cm4gKFxuICAgICAgICAgICAgPG1haW4gY2xhc3NOYW1lPVwiYXBwLWNvbnRlbnQgZGFzaGJvYXJkXCI+XG4gICAgICAgICAgICAgICAge3RoaXMucHJvcHMuY2hpbGRyZW59XG4gICAgICAgICAgICA8L21haW4+XG4gICAgICAgICk7XG4gICAgfVxufVxuXG5cblxuLyoqIFdFQlBBQ0sgRk9PVEVSICoqXG4gKiogLi9hcHAvY29tcG9uZW50cy9kYXNoYm9hcmQvRGFzaGJvYXJkLmpzXG4gKiovIiwiaW1wb3J0IFJlYWN0IGZyb20gJ3JlYWN0JztcblxuaW1wb3J0IExpc3QgZnJvbSAnLi4vY29tbW9uL0xpc3QnO1xuaW1wb3J0IENvbXBhY3RCaWxsIGZyb20gJy4vQ29tcGFjdEJpbGwnO1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBMYXRlc3RCaWxscyBleHRlbmRzIFJlYWN0LkNvbXBvbmVudCB7XG4gICAgY29uc3RydWN0b3IocHJvcHMpIHtcbiAgICAgICAgc3VwZXIocHJvcHMpO1xuICAgICAgICB0aGlzLnN0YXRlID0ge2l0ZW1zOiBbXX07XG4gICAgfVxuXG4gICAgcmVuZGVyKCkge1xuICAgICAgICByZXR1cm4gKFxuICAgICAgICAgICAgPHNlY3Rpb24gY2xhc3NOYW1lPVwibGF0ZXN0LWJpbGxzXCI+XG4gICAgICAgICAgICAgICAgPGhlYWRlciBjbGFzc05hbWU9XCJzZWN0aW9uLWhlYWRlclwiPlxuICAgICAgICAgICAgICAgICAgICA8aDMgY2xhc3NOYW1lPVwidGl0bGVcIj5MYXRlc3QgQmlsbHM8L2gzPlxuICAgICAgICAgICAgICAgIDwvaGVhZGVyPlxuICAgICAgICAgICAgICAgIDxzZWN0aW9uIGNsYXNzTmFtZT1cInNlY3Rpb24tY29udGVudFwiPlxuICAgICAgICAgICAgICAgICAgICA8TGlzdCBpdGVtcz17dGhpcy5zdGF0ZS5pdGVtc30gaXRlbVR5cGU9e0NvbXBhY3RCaWxsfS8+XG4gICAgICAgICAgICAgICAgPC9zZWN0aW9uPlxuICAgICAgICAgICAgPC9zZWN0aW9uPlxuICAgICAgICApO1xuICAgIH1cblxuICAgIGNvbXBvbmVudERpZE1vdW50KCkge1xuICAgICAgICBmZXRjaCgnL2FwaS9sYXRlc3QtYmlsbHMnKS50aGVuKChyZXNwb25zZSkgPT4ge1xuICAgICAgICAgICAgcmV0dXJuIHJlc3BvbnNlLmpzb24oKTtcbiAgICAgICAgfSkudGhlbigoZGF0YSkgPT4ge1xuICAgICAgICAgICAgdGhpcy5zZXRTdGF0ZSh7aXRlbXM6IGRhdGEuaXRlbXN9KTtcbiAgICAgICAgfSkuY2F0Y2goKGVycikgPT4ge1xuICAgICAgICAgICAgdGhyb3cgbmV3IEVycm9yKGVycik7XG4gICAgICAgIH0pO1xuICAgIH1cbn1cblxuXG5cbi8qKiBXRUJQQUNLIEZPT1RFUiAqKlxuICoqIC4vYXBwL2NvbXBvbmVudHMvYmlsbC9MYXRlc3RCaWxscy5qc1xuICoqLyIsImltcG9ydCBSZWFjdCBmcm9tICdyZWFjdCc7XG5cbmV4cG9ydCBkZWZhdWx0IGNsYXNzIExpc3QgZXh0ZW5kcyBSZWFjdC5Db21wb25lbnQge1xuXG4gICAgcmVuZGVyKCkge1xuICAgICAgICBjb25zdCBJdGVtVHlwZSA9IHRoaXMucHJvcHMuaXRlbVR5cGU7XG4gICAgICAgIGNvbnN0IGl0ZW1zID0gdGhpcy5wcm9wcy5pdGVtcyB8fCBbXTtcbiAgICAgICAgY29uc3QgbWFya3VwSXRlbXMgPSB0aGlzLmNyZWF0ZUl0ZW1zTWFya3VwKGl0ZW1zLCBJdGVtVHlwZSk7XG5cbiAgICAgICAgcmV0dXJuICg8dWwgY2xhc3NOYW1lPVwidWktbGlzdFwiPnttYXJrdXBJdGVtc308L3VsPik7XG4gICAgfVxuXG4gICAgY3JlYXRlSXRlbXNNYXJrdXAoaXRlbXMsIFR5cGUpIHtcbiAgICAgICAgY29uc3QgbWFya3VwSXRlbXMgPSBpdGVtcy5tYXAoKGl0ZW0pID0+IHsgICAgICAgICAgICBcbiAgICAgICAgICAgIHJldHVybiAoXG4gICAgICAgICAgICAgICAgPGxpIGNsYXNzTmFtZT1cInVpLWxpc3QtaXRlbVwiIGtleT17aXRlbS5pZH0+XG4gICAgICAgICAgICAgICAgICAgIDxUeXBlIGRhdGE9e2l0ZW19Lz5cbiAgICAgICAgICAgICAgICA8L2xpPlxuICAgICAgICAgICAgKTtcbiAgICAgICAgfSk7XG5cbiAgICAgICAgcmV0dXJuIG1hcmt1cEl0ZW1zO1xuICAgIH1cbn1cblxuXG5cbi8qKiBXRUJQQUNLIEZPT1RFUiAqKlxuICoqIC4vYXBwL2NvbXBvbmVudHMvY29tbW9uL0xpc3QuanNcbiAqKi8iLCJpbXBvcnQgUmVhY3QgZnJvbSAncmVhY3QnO1xuXG5leHBvcnQgZGVmYXVsdCBjbGFzcyBDb21wYWN0QmlsbCBleHRlbmRzIFJlYWN0LkNvbXBvbmVudCB7XG4gICAgcmVuZGVyKCkge1xuICAgICAgICBjb25zdCBkYXRhID0gdGhpcy5wcm9wcy5kYXRhO1xuICAgICAgICBjb25zdCBhbW91bnQgPSBgJCR7ZGF0YS5hbW91bnR9YDtcblxuICAgICAgICByZXR1cm4gKFxuICAgICAgICAgICAgPGRpdiBjbGFzc05hbWU9XCJiaWxsIGNvbXBhY3QtYmlsbFwiPlxuICAgICAgICAgICAgICAgIDxpbWcgY2xhc3NOYW1lPVwiaWNvblwiIHNyYz17ZGF0YS5pY29ufS8+XG4gICAgICAgICAgICAgICAgPGRpdiBjbGFzc05hbWU9XCJpbmZvLWNvbnRhaW5lclwiPlxuICAgICAgICAgICAgICAgICAgICA8aDQgY2xhc3NOYW1lPVwidGl0bGVcIj57ZGF0YS52ZW5kb3J9PC9oND5cbiAgICAgICAgICAgICAgICAgICAgPHNwYW4gY2xhc3NOYW1lPVwicGVyaW9kXCI+e2RhdGEucGVyaW9kfTwvc3Bhbj5cbiAgICAgICAgICAgICAgICA8L2Rpdj5cbiAgICAgICAgICAgICAgICA8c3BhbiBjbGFzc05hbWU9XCJhbW91bnRcIj57YW1vdW50fTwvc3Bhbj5cbiAgICAgICAgICAgIDwvZGl2PlxuICAgICAgICApO1xuICAgIH1cbn1cblxuXG5cbi8qKiBXRUJQQUNLIEZPT1RFUiAqKlxuICoqIC4vYXBwL2NvbXBvbmVudHMvYmlsbC9Db21wYWN0QmlsbC5qc1xuICoqLyJdLCJzb3VyY2VSb290IjoiIn0=