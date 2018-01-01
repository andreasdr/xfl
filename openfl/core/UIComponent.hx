package openfl.core;

import openfl.display.XFLSprite;
import xfl.XFL;
import xfl.dom.DOMTimeline;

/**
 * UI component
 */
class UIComponent extends XFLSprite {

    public var disabled(get,set): Bool;

    private var _disabled: Bool;
    private var _originalWidth: Float;
    private var _originalHeight: Float;
    private var _width: Float;
    private var _height: Float;

    private var _scrolling: Bool;
    private var _scrollY: Float;

    private var styles: Map<String, Dynamic>;

    public function new(name: String, xlfSymbolArguments: XFLSymbolArguments = null)
    {
        super(xlfSymbolArguments);

        // defaults
        _disabled = false;
        styles = new Map<String, Dynamic>();

        // size
        _width = 0.0;
        _height = 0.0;

        // determine from component avarar if we have any
        if (getXFLDisplayObject("Component_avatar") == null) return;
        _originalWidth = getXFLDisplayObject("Component_avatar").width;
        _originalHeight = getXFLDisplayObject("Component_avatar").height;
        _width = _originalWidth;
        _height = _originalHeight;

        // remove component avatar
        removeChild(getXFLDisplayObject("Component_avatar"));
    }

    public function get_disabled(): Bool {
        return _disabled;
    }

    public function set_disabled(_disabled: Bool): Bool {
        return this._disabled = _disabled;
    }

    #if flash
        @:getter(width) public function get_width(): Float {
            return _width;
        }

        @:setter(width) public function set_width(_width: Float) {
            setSize(_width, _height);
        }

        @:getter(height) public function get_height(): Float {
            return _height;
        }

        @:setter(height) public function set_height(_height: Float) {
            setSize(_width, _height);
        }
    #else
        public override function get_scaleX(): Float {
            return 1.0;
        }

        public override function set_scaleX(_scaleX: Float): Float {
            setSize(_originalWidth * _scaleX, _height);
            return 1.0;
        }

        public override function get_scaleY(): Float {
            return 1.0;
        }

        public override function set_scaleY(_scaleY: Float): Float {
            setSize(_width, _originalHeight * _scaleY);
            return 1.0;
        }

        public override function get_width(): Float {
            return _width;
        }

        public override function set_width(_width: Float): Float {
            setSize(_width, _height);
            return _width;
        }

        public override function get_height(): Float {
            return _height;
        }

        public override function set_height(_height: Float): Float {
            setSize(_width, _height);
            return _height;
        }
    #end

    private function draw(): Void {
    }

    public function drawFocus(draw: Bool): Void {
    }

    public function setStyle(style: String, value: Dynamic): Void {
        styles.set(style, value);
        draw();
    }

    public function setSize(_width: Float, _height: Float): Void {
        this._width = _width;
        this._height = _height;
    }

}
