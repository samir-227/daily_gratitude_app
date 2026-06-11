import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;
  String? _currentRecordingPath;

  StreamSubscription<Duration>? get positionSub => _positionSub;
  StreamSubscription<Duration?>? get durationSub => _durationSub;

  Future<String> get _recordingsDir async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory('${appDir.path}/recordings');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir.path;
  }

  Future<void> startRecording() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.measurement,
    ));
    final dir = await _recordingsDir;
    _currentRecordingPath = '$dir/temp_recording.wav';
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 16000,
        bitRate: 128000,
      ),
      path: _currentRecordingPath!,
    );
  }

  Future<String> stopRecording() async {
    final path = await _recorder.stop();
    _currentRecordingPath = path;
    return path ?? '';
  }

  Future<void> cancelRecording() async {
    await _recorder.cancel();
    _currentRecordingPath = null;
  }

  Future<int> getRecordingDuration() async {
    if (_currentRecordingPath == null) return 0;
    final duration = await _recorder.stop();
    if (duration == null) return 0;
    return 0;
  }

  Future<String> moveToPermStorage(String tempPath, String entryId) async {
    final dir = await _recordingsDir;
    final permPath = '$dir/$entryId.wav';
    final tempFile = File(tempPath);
    if (await tempFile.exists()) {
      await tempFile.rename(permPath);
      return '$entryId.wav';
    }
    return '';
  }

  Future<bool> playAudio(String filePath) async {
    final dir = await _recordingsDir;
    var file = File(filePath);
    if (!await file.exists()) {
      final filename = filePath.split('/').last;
      file = File('$dir/$filename');
    }
    if (!await file.exists()) return false;
    try {
      await _player.stop();
      await _player.setAudioSource(AudioSource.file(file.path));
      await _player.play();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> pauseAudio() async {
    await _player.pause();
  }

  Future<void> stopAudio() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Stream<Duration> get playbackPosition => _player.positionStream;
  Stream<Duration?> get totalDuration => _player.durationStream;

  Future<bool> isPlaying() async => _player.playing;

  Future<void> deleteRecording(String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }

  Future<void> dispose() async {
    await _positionSub?.cancel();
    await _durationSub?.cancel();
    _recorder.dispose();
    _player.dispose();
  }
}
