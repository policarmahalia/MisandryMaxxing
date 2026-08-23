import { Howl } from 'howler';
import { useEffect, useRef } from 'react';

function MusicPlayer() {
  const soundRef = useRef(null);

  useEffect(() => {
    // Create the sound
    soundRef.current = new Howl({
        src: [import.meta.env.BASE_URL + 'assets/audio/bgmusic.mp3'],
      loop: true,
      volume: 0.3,
      autoplay: true,
    });

    // Cleanup when component unmounts
    return () => {
      if (soundRef.current) {
        soundRef.current.stop();
        soundRef.current.unload();
      }
    };
  }, []);

  return null; // This component doesn't render anything
}

export default MusicPlayer;