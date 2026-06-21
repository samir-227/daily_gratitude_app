import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_theme.dart';
import '../../../../data/models/gratitude_entry.dart';

class EntryDetailScreen extends StatefulWidget {
  final GratitudeEntry entry;
  const EntryDetailScreen({super.key, required this.entry});

  @override
  State<EntryDetailScreen> createState() => _EntryDetailScreenState();
}

class _EntryDetailScreenState extends State<EntryDetailScreen> {
  final _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration? _duration;
  String? _error;
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<Duration?>? _durationSub;

  @override
  void initState() {
    super.initState();
    _positionSub = _player.positionStream.listen((pos) {
      if (!mounted) return;
      setState(() {
        _position = pos;
        if (_duration != null && pos >= _duration! && _duration!.inMilliseconds > 0) {
          _isPlaying = false;
        }
      });
    });
    _durationSub = _player.durationStream.listen((dur) {
      if (mounted) setState(() => _duration = dur);
    });
  }

  @override
  void dispose() {
    _player.stop();
    _player.dispose();
    _positionSub?.cancel();
    _durationSub?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String _formatDate(DateTime dt) {
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  String _formatTime(DateTime dt) {
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Color _moodColor(String? mood) {
    switch (mood) {
      case 'grateful': return AppColors.emotionJoy;
      case 'happy': return AppColors.emotionHope;
      case 'calm': return AppColors.emotionPeace;
      case 'loved': return AppColors.emotionLoved;
      case 'reflective': return AppColors.emotionLoved;
      case 'grounded': return AppColors.emotionGrounded;
      default: return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final brightness = CupertinoTheme.of(context).brightness ?? Brightness.dark;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.surface(0, brightness),
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.surface(1, brightness),
        border: Border.all(color: AppColors.surface(1, brightness)),
        middle: Text(_formatDate(entry.createdAt),
          style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface(brightness))),
        previousPageTitle: AppStrings.home,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.standard),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entry.moodTag != null) ...[
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSpacing.cozy, vertical: AppSpacing.compact),
                      decoration: BoxDecoration(
                        color: _moodColor(entry.moodTag).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(AppStrings.moodLabel(entry.moodTag),
                            style: AppTextStyles.labelLarge.copyWith(
                              color: _moodColor(entry.moodTag))),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSpacing.cozy),
                    Text(_formatTime(entry.createdAt),
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurface(brightness, tertiary: true))),
                  ],
                ),
                SizedBox(height: AppSpacing.standard),
              ],
              if (entry.isVoiceEntry && entry.audioPath != null) ...[
                _buildAudioPlayer(entry.audioPath!, brightness),
                if (_error != null)
                  Padding(
                    padding: EdgeInsets.only(top: AppSpacing.tight),
                    child: Text(_error!,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
                  ),
                SizedBox(height: AppSpacing.standard),
              ],
              Container(
                width: double.infinity,
          padding: EdgeInsets.all(AppSpacing.standard),
                decoration: BoxDecoration(
                  color: AppColors.surface(1, brightness),
                  borderRadius: BorderRadius.circular(AppRadius.generous),
                ),
                child: Text(
                  entry.text,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurface(brightness), height: 1.6),
                ),
              ),
              if (entry.topics.isNotEmpty) ...[
                SizedBox(height: AppSpacing.standard),
                Text('المواضيع',
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurface(brightness, secondary: true))),
                SizedBox(height: AppSpacing.tight),
                Wrap(
                  spacing: AppSpacing.tight,
                  runSpacing: AppSpacing.tight,
                  children: entry.topics.map((topic) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.cozy, vertical: AppSpacing.compact),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(topic,
                      style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayer(String audioPath, Brightness brightness) {
    final outlineColor = brightness == Brightness.dark ? AppColors.outline : AppColors.lightOutline;
    return Container(
      padding: EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface(1, brightness),
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: outlineColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () async {
                  if (_isPlaying) {
                    await _player.pause();
                    if (!mounted) return;
                    setState(() => _isPlaying = false);
                  } else {
                    try {
                      final appDir = await getApplicationDocumentsDirectory();
                      final recordingsDir = Directory('${appDir.path}/recordings');
                      var file = File(audioPath);
                      if (!await file.exists()) {
                        final filename = audioPath.split('/').last;
                        file = File('${recordingsDir.path}/$filename');
                      }
                      if (!await file.exists()) {
                        if (!mounted) return;
                        setState(() => _error = AppStrings.audioFileNotFound);
                        return;
                      }
                      await _player.stop();
                      await _player.setAudioSource(AudioSource.file(file.path));
                      await _player.play();
                      if (!mounted) return;
                      setState(() {
                        _isPlaying = true;
                        _error = null;
                      });
                    } catch (e) {
                      if (!mounted) return;
                      setState(() {
                        _isPlaying = false;
                        _error = '${AppStrings.playbackFailed}$e';
                      });
                    }
                  }
                },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying
                            ? CupertinoIcons.pause_fill
                            : CupertinoIcons.play_fill,
                        size: 18.w,
                        color: AppColors.primary,
                      ),
                    ),
              ),
              SizedBox(width: AppSpacing.standard),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_formatDuration(_position)} / ${_formatDuration(_duration ?? Duration.zero)}',
                      style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurface(brightness, secondary: true))),
                    CupertinoSlider(
                      value: _duration != null && _duration!.inMilliseconds > 0
                          ? (_position.inMilliseconds / _duration!.inMilliseconds).clamp(0.0, 1.0)
                          : 0,
                      onChanged: (v) {
                        if (_duration != null) {
                          final pos = Duration(milliseconds: (v * _duration!.inMilliseconds).round());
                          _player.seek(pos);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
