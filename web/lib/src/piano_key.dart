part of piano;

class PianoKey extends Sprite {

  final String note;
  final dynamic sound;

  PianoKey(this.note, this.sound) {
    Shape keyUp = new Shape(), keyDown = new Shape();
    
    if (note.contains('#')) { //black key
      keyUp.graphics
          ..beginPath()
          ..lineTo(0, 87)
          ..arcTo(0, 92, 5, 92, 5)
          ..lineTo(25, 92)
          ..arcTo(30, 92, 30, 87, 5)
          ..lineTo(30, 0)
          ..lineTo(0, 0)
          ..closePath()
          ..fillColor(0xff000000);
      
      keyDown.graphics
                ..beginPath()
                ..lineTo(0, 87)
                ..arcTo(0, 92, 5, 92, 5)
                ..lineTo(25, 92)
                ..arcTo(30, 92, 30, 87, 5)
                ..lineTo(30, 0)
                ..lineTo(0, 0)
                ..closePath()
                ..fillColor(0xff333333);
      
      keyUp.applyCache(0, 0, 30, 92);
      keyDown.applyCache(0, 0, 30, 92);

    } else {
      //45 x 140
      keyUp.graphics
        ..beginPath()
        ..moveTo(.5, .5)
        ..lineTo(.5,134.5)
        ..arcTo(.5, 139.5, 4.5, 139.5, 5)
        ..lineTo(39.5, 139.5)
        ..arcTo(44.5, 139.5, 44.5, 134.5, 5)
        ..lineTo(44.5, .5)
        ..lineTo(.5, .5)
        ..closePath()
        ..strokeColor(Color.Black, 1)
        ..fillColor(0xffffffff);
      
      keyDown.graphics
        ..beginPath()
        ..moveTo(.5, .5)
        ..lineTo(.5,134.5)
        ..arcTo(.5, 139.5, 4.5, 139.5, 5)
        ..lineTo(39.5, 139.5)
        ..arcTo(44.5, 139.5, 44.5, 134.5, 5)
        ..lineTo(44.5, .5)
        ..lineTo(.5, .5)
        ..closePath()
        ..strokeColor(Color.Black, 1)
        ..fillColor(0xffcccccc);
      
      keyUp.applyCache(0, 0, 45, 140);
      keyDown.applyCache(0, 0, 45, 140);
    }
    
    this.addChild(keyDown);
    this.addChild(keyUp);

    // add mose event handlers
    this.useHandCursor = true;
    this.onMouseDown.listen(_keyDown);
    this.onMouseOver.listen(_keyDown);
    this.onMouseUp.listen(_keyUp);
    this.onMouseOut.listen(_keyUp);
  }

  _keyDown(MouseEvent me) {
    if (me.buttonDown) {
      this.sound.play();
      this.getChildAt(1).alpha=0;
      this.dispatchEvent(new PianoEvent(this.note));
    }
  }

  _keyUp(MouseEvent me) {
    this.getChildAt(1).alpha=1;
  }
}
