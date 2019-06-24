import Felgo 3.0
import QtQuick 2.0

Item {
  id: audioManager

  // Use Sound IDs to play Sounds e.g. audioManager.play(audioManager.idBALLOON_PUSHED)
  property int idBALLOON_PUSHED         : 1
  property int idBALLOON_EXPLODED       : 2
  property int idGROUND_FALL            : 3
  property int idMAIN_MUSIC             : 4
  property int idSELECTION_CHANGED      : 5



  function play(clipID) {

    switch(clipID) {
    case idBALLOON_PUSHED:
      //balloon_pushed.play()
      break
    case idBALLOON_EXPLODED:
      balloon_exploded.play()
      break
    case idGROUND_FALL:
      //ground_fall.play()
      break
    case idMAIN_MUSIC:
      //main_music.play()
      break
    case idSELECTION_CHANGED:
      //selection_changed.play()
      break
    }
  }

  SoundEffect {
    id: balloon_pushed
    source: "../../assets/audio/sfx_die.wav"
  }
  SoundEffect {
    id: balloon_exploded
    source: "../../assets/audio/explode.wav"
  }
  SoundEffect {
    id: ground_fall
    source: "../../assets/audio/sfx_point.wav"
  }
  SoundEffect {
    id: main_music
    source: "../../assets/audio/sfx_swooshing.wav"
  }
  SoundEffect {
    id: selection_changed
    source: "../../assets/audio/selection_changed.wav"
  }
}
