import Felgo 3.0
import QtQuick 2.0



BoxCollider {

      bodyType: Body.Static
      fixture.onBeginContact: {
                   // when colliding with another entity, play the sound and start particleEffect
                   audioManager.play(audioManager.idGROUND_FALL)
                   //collisionParticleEffect.start();
               }
    }
      /*
    // the soundEffect is played at a collision


        // the ParticleEffect is started at a collision
        Particle {
            id: collisionParticleEffect
            //fileName: "SmokeParticle.json"
        }
      */


