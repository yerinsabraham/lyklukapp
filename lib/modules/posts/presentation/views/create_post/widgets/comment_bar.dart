import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/utils/constant/font_constant.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class CommentBar extends HookConsumerWidget {
  const CommentBar({super.key});

  // tiny emoji “dictionary” – add more as you like
  static final List<_Emoji> _emojiDb = [
    _Emoji('😊', ['smile', 'happy', 'thanks', 'nice', 'good', 'joy']),
    _Emoji('😂', ['lol', 'laugh', 'funny', 'lmao']),
    _Emoji('😍', ['love', 'heart', 'cute', 'lovely']),
    _Emoji('🥹', ['tears', 'touching', 'aww']),
    _Emoji('😎', ['cool', 'boss', 'swag']),
    _Emoji('😁', ['grin', 'cheese', 'happy']),
    _Emoji('😢', ['sad', 'cry', 'tears']),
    _Emoji('🔥', ['fire', 'lit', 'hot']),
    _Emoji('👏', ['clap', 'bravo', 'nice']),
    _Emoji('🙏', ['pls', 'please', 'pray', 'thanks', 'gratitude']),
    _Emoji('🥳', ['party', 'celebrate', 'congrats']),
    _Emoji('🤯', ['mindblown', 'wow']),
    _Emoji('🤔', ['think', 'hmm']),
    _Emoji('😮', ['wow', 'surprised']),
    _Emoji('😴', ['sleep', 'tired', 'zzz']),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final focus = useFocusNode();
    final text = useState('');

    useEffect(() {
      controller.addListener(() => text.value = controller.text);
      return null;
    }, []);

    // compute top 3 matches from the current text
    List<_Emoji> topMatches(String input) {
      final q = input.toLowerCase();
      if (q.trim().isEmpty) {
        // default “mood” set like the mock
        return [
          _Emoji('😌', const []),
          _Emoji('😎', const []),
          _Emoji('😁', const []),
        ];
      }
      // score by keyword presence
      final scored =
          _emojiDb
              .map((e) {
                int score = 0;
                for (final k in e.keywords) {
                  if (q.contains(k)) score += 2;
                }
                // also check raw word match
                for (final word in q.split(RegExp(r'\s+'))) {
                  if (word.isEmpty) continue;
                  if (e.keywords.contains(word)) score += 3;
                }
                return (e, score);
              })
              .where((t) => t.$2 > 0)
              .toList()
            ..sort((a, b) => b.$2.compareTo(a.$2));
      final picks = scored.take(3).map((t) => t.$1).toList();
      // fallback if nothing matched
      return picks.isNotEmpty
          ? picks
          : [
            _Emoji('😊', const []),
            _Emoji('😎', const []),
            _Emoji('😁', const []),
          ];
    }

    void openEmojiPicker() {
      final matches = topMatches(text.value);
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.black.withValues(alpha: .6),
        barrierColor: Colors.black54,
        isDismissible: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        builder: (_) {
          return SafeArea(
            top: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                16.w,
                14.h,
                16.w,
                14.h + MediaQuery.of(context).padding.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  12.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children:
                        matches.map((e) {
                          return _EmojiButton(
                            emoji: e.char,
                            onTap: () {
                              // insert with a space
                              final selection = controller.selection;
                              final textVal = controller.text;
                              final insert = '${e.char} ';
                              if (selection.isValid) {
                                final newText = textVal.replaceRange(
                                  selection.start,
                                  selection.end,
                                  insert,
                                );
                                controller.text = newText;
                                controller.selection = TextSelection.collapsed(
                                  offset: (selection.start + insert.length),
                                );
                              } else {
                                controller.text = '$textVal$insert';
                                controller.selection = TextSelection.collapsed(
                                  offset: controller.text.length,
                                );
                              }
                              Navigator.of(context).pop();
                              focus.requestFocus();
                            },
                          );
                        }).toList(),
                  ),
                  10.verticalSpace,
                ],
              ),
            ),
          );
        },
      );
    }

    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: 12.w,
        right: 12.w,
        bottom: MediaQuery.of(context).padding.bottom + 10.h,
        top: 8.h,
      ),
      child: Row(
        children: [
          // Make the pill expand to fill available width
          Expanded(
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  // Text field takes remaining space inside the pill
                  Expanded(
                    child: TextField(
                      focusNode: focus,
                      controller: controller,
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Add a comment…',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(
                          color: const Color(
                            AppColors.textColor3,
                          ).withValues(alpha: .5),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: FontConstant.bricolage,
                        ),
                      ),
                      onSubmitted: (_) => focus.unfocus(),
                    ),
                  ),
                  10.horizontalSpace,
                  GestureDetector(
                    onTap: openEmojiPicker,
                    child: _EmojiPreviewRow(emojis: topMatches(text.value)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// shows 3 emojis inline (like your mock)
class _EmojiPreviewRow extends StatelessWidget {
  const _EmojiPreviewRow({required this.emojis});
  final List<_Emoji> emojis;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          emojis
              .take(3)
              .map(
                (e) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Text(e.char, style: TextStyle(fontSize: 20.sp)),
                ),
              )
              .toList(),
    );
  }
}

class _EmojiButton extends StatelessWidget {
  const _EmojiButton({required this.emoji, required this.onTap});
  final String emoji;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 36,
      child: Container(
        width: 64.w,
        height: 64.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white24),
        ),
        child: Text(emoji, style: TextStyle(fontSize: 30.sp)),
      ),
    );
  }
}

class _Emoji {
  final String char;
  final List<String> keywords;
  const _Emoji(this.char, this.keywords);
}
