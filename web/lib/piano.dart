library piano;

import 'dart:html' as html;
import 'package:stagexl/stagexl.dart';

part 'src/piano_event.dart';
part 'src/piano_key.dart';

class Piano extends DisplayObjectContainer {

  Stage stage;
  RenderLoop renderLoop;
  ResourceManager resourceManager;
  
  final List<String> _pianoNotes = [
    'C3', 'C#3', 'D3', 'D#3', 'E3', 'F3', 'F#3', 'G3', 'G#3', 'A3', 'A#3', 'B3',
    'C4', 'C#4', 'D4', 'D#4', 'E4', 'F4', 'F#4', 'G4', 'G#4', 'A4', 'A#4', 'B4', 'C5'];

  Map<String, PianoKey> _pianoKeys = new Map<String, PianoKey>();

  Piano() {
    
    stage = new Stage(html.querySelector('#stage'), webGL: true);
    renderLoop = new RenderLoop();
    renderLoop.addStage(stage);

    resourceManager = new ResourceManager()..addSoundSprite('notes', 'sounds/notes.json');
    resourceManager.load().then((_) => _init());
   

  }

  void _init() {              
                      
        this
            ..x = 120
            ..y = 30
            ..addTo(stage);
    
    for(int n = 0, x = 0; n < _pianoNotes.length; n++) {

          var pianoNote = _pianoNotes[n];
          var sound = resourceManager.getSoundSprite('notes').getSegment(pianoNote);
          var pianoKey = new PianoKey(pianoNote, sound);

          pianoKey.on(PianoEvent.NOTE_PLAYED).listen((event) {
            this.dispatchEvent(event);
          });

          _pianoKeys[pianoNote] = pianoKey;

          if (pianoNote.contains('#')) {
            pianoKey.x = x - 15;
            pianoKey.y = 35;
            addChild(pianoKey);
          } else {
            pianoKey.x = x;
            pianoKey.y = 35;
            addChildAt(pianoKey, 0);
            x = x + 45;
          }
        }
  }

}