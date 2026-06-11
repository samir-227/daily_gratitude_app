import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_constants.dart';
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

  String _moodEmoji(String? mood) {
    switch (mood) {
      case 'grateful': return '\u{1F60A}';
      case 'happy': return '\u{1F600}';
      case 'calm': return '\u{1F9D8}';
      case 'loved': return '\u{1F497}';
      case 'reflective': return '\u{1F914}';
      case 'grounded': return '\u{1F331}';
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    return CupertinoPageScaffold(
      backgroundColor: AppColors.surface0,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.surface1,
        border: Border.all(color: AppColors.surface1),
        middle: Text(_formatDate(entry.createdAt),
          style: AppTextStyles.titleSmall.copyWith(color: AppColors.textPrimary)),
        previousPageTitle: AppStrings.home,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(AppSpacing.generous),
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
                        color: _moodColor(entry.moodTag).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(_moodEmoji(entry.moodTag), style: const TextStyle(fontSize: 16)),
                          SizedBox(width: AppSpacing.tight),
                          Text(entry.moodTag!,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: _moodColor(entry.moodTag))),
                        ],
                      ),
                    ),
                    SizedBox(width: AppSpacing.cozy),
                    Text(_formatTime(entry.createdAt),
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.textTertiary)),
                  ],
                ),
                SizedBox(height: AppSpacing.generous),
              ],
              if (entry.isVoiceEntry && entry.audioPath != null) ...[
                _buildAudioPlayer(entry.audioPath!),
                if (_error != null)
                  Padding(
                    padding: EdgeInsets.only(top: AppSpacing.tight),
                    child: Text(_error!,
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.error)),
                  ),
                SizedBox(height: AppSpacing.generous),
              ],
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppSpacing.generous),
                decoration: BoxDecoration(
                  color: AppColors.surface1,
                  borderRadius: BorderRadius.circular(AppRadius.generous),
                ),
                child: Text(
                  entry.text,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.textPrimary, height: 1.8),
                ),
              ),
              if (entry.topics.isNotEmpty) ...[
                SizedBox(height: AppSpacing.generous),
                Text('المواضيع',
                  style: AppTextStyles.labelLarge.copyWith(color: AppColors.textSecondary)),
                SizedBox(height: AppSpacing.tight),
                Wrap(
                  spacing: AppSpacing.tight,
                  runSpacing: AppSpacing.tight,
                  children: entry.topics.map((topic) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.cozy, vertical: AppSpacing.compact),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(topic,
                      style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayer(String audioPath) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.standard),
      decoration: BoxDecoration(
        color: AppColors.surface1,
        borderRadius: BorderRadius.circular(AppRadius.generous),
        border: Border.all(color: AppColors.outline.withOpacity(0.3)),
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
                      final file = File(audioPath);
                      if (!await file.exists()) {
                        if (!mounted) return;
                        setState(() => _error = AppStrings.audioFileNotFound);
                        return;
                      }
                      await _player.stop();
                      await _player.setAudioSource(AudioSource.file(audioPath));
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
                  width: kSpace48,
                  height: kSpace48,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isPlaying
                        ? CupertinoIcons.pause_fill
                        : CupertinoIcons.play_fill,
                    size: 22.w,
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
                      style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
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
              const Icon(CupertinoIcons.waveform_path, size: 20, color: AppColors.textTertiary),
            ],
          ),
        ],
      ),
    );
  }
}
