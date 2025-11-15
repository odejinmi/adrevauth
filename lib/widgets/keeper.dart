
const storageKey = 'gr00veup!sb@d@ss';
const base_url = 'https://dolphin-app-hprd3.ondigitalocean.app';


String formatSecondsToMMSS(double seconds) {
  Duration duration = Duration(seconds: seconds.toInt());
  return '${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
}

String formatDurationToMMSS(Duration duration) {
  return '${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
}



