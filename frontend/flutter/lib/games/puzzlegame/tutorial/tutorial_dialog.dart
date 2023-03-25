import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:zenith/games/puzzlegame/data/board_config.dart';
import 'package:zenith/games/puzzlegame/data/game_state.dart';
import 'package:zenith/games/puzzlegame/puzzle/puzzle_piece.dart';

class TutorialDialog extends StatefulWidget {
  final void Function(bool hideText) onDismiss;

  const TutorialDialog({Key? key, required this.onDismiss}) : super(key: key);

  @override
  _TutorialDialogState createState() => _TutorialDialogState();
}

class _TutorialDialogState extends State<TutorialDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1500),
  )..forward();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _Dialog(widget.onDismiss);
  }
}

class _Dialog extends StatefulWidget {
  final void Function(bool hideText) onDismiss;

  const _Dialog(this.onDismiss, {Key? key}) : super(key: key);

  @override
  State<_Dialog> createState() => _DialogState();
}

class _DialogState extends State<_Dialog> {
  final bool _hideTexts = false;

  @override
  Widget build(BuildContext context) {
    final dialog = Stack(
      children: [
        CupertinoPopupSurface(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
              child: _buildTutorialContent(context),
            ),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: ClipOval(
            child: Material(
              shape: const CircleBorder(),
              child: CloseButton(
                onPressed: () => widget.onDismiss(_hideTexts),
              ),
            ),
          ),
        ),
      ],
    );

    final responsiveDialog = Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 650) {
            return SafeArea(
              minimum: const EdgeInsets.all(32),
              child: dialog,
            );
          }
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight * 0.8,
              maxWidth: 600,
            ),
            child: dialog,
          );
        },
      ),
    );

    return WillPopScope(
      // Dismiss the tutorial dialog when the user taps the back button,
      // instead of quitting the entire app.
      child: responsiveDialog,
      onWillPop: () async {
        widget.onDismiss(_hideTexts);
        return false;
      },
    );
  }

  Widget _buildTutorialContent(BuildContext context) {
    final header = TextStyle(
      fontWeight: FontWeight.bold,
      color: BoardConfig.of(context).pieceColor2,
      fontSize: 20,
      height: 2.0,
    );
    const body = TextStyle(
      fontWeight: FontWeight.normal,
      color: Colors.black87,
      height: 1.2,
    );
    final em = TextStyle(
      fontWeight: FontWeight.bold,
      color: BoardConfig.of(context).pieceColor1,
      height: 1.2,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'How to Play',
          style: header.copyWith(fontSize: 32),
          textAlign: TextAlign.center,
        ),
        RichText(
          text: TextSpan(
            style: body,
            children: [
              TextSpan(text: '\nObjective\n', style: header),
              const TextSpan(
                  text: '\nThe goal is to move ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: '🕵🏻', style: em),
              const TextSpan(
                  text: ' to ', style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: 'the Jail', style: em),
              const TextSpan(
                  text: ' in as few ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: 'steps', style: em),
              const TextSpan(
                  text: ' as possible.',
                  style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ),
        RichText(
          text: TextSpan(
            style: body,
            children: [
              TextSpan(text: '\nPieces\n', style: header),
              const TextSpan(
                  text: '\nThe largest piece is ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: '🕵🏻', style: em),
              const TextSpan(
                  text: '. All other pieces are ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(
                text: '👮🏻',
                style: em,
              ),
              const TextSpan(
                  text: ' preventing ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: '🕵🏻', style: em),
              const TextSpan(
                  text: ' from reaching ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: 'the Jail', style: em),
              const TextSpan(
                  text: '. Swipe them away to clear a path for ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: '🕵🏻', style: em),
              const TextSpan(
                  text: '.', style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            _buildPuzzlePiece(
              Piece(0, label: '🕵🏻', width: 2, height: 2, x: 0, y: 0),
            ),
            Text('CHOR', style: em),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPuzzlePiece(
                  Piece(1, label: '👮🏻', width: 2, height: 1, x: 0, y: 0),
                ),
                _buildPuzzlePiece(
                  Piece(2, label: '👮🏻', width: 1, height: 1, x: 0, y: 0),
                ),
                _buildPuzzlePiece(
                  Piece(3, label: '👮🏻', width: 1, height: 2, x: 0, y: 0),
                ),
              ],
            ),
            Text('Police', style: em),
          ],
        ),
        RichText(
          text: TextSpan(
            style: body,
            children: [
              TextSpan(
                text: '\nThe Jail\n',
                style: header,
              ),
              const TextSpan(
                  text: '\nThe jail is located ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: 'at the bottom', style: em),
              const TextSpan(
                  text: ' of the game board for each level. Once ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: '🕵🏻', style: em),
              const TextSpan(
                  text: ' reaches the Jail, '
                      'the game will advance to the next level.',
                  style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          text: TextSpan(
            style: body,
            children: [
              TextSpan(text: '\nSteps\n', style: header),
              const TextSpan(
                  text: '\nThe game is not timed, but there is a ',
                  style: TextStyle(color: Colors.blueGrey)),
              TextSpan(text: 'step counter', style: em),
              const TextSpan(
                  text:
                      ' at the top. Solving the puzzle is already an incredible'
                      " achievement, so don't be stressed about the steps.",
                  style: TextStyle(color: Colors.blueGrey)),
            ],
          ),
        ),
        const SizedBox(height: 48),
        ElevatedButton(
          onPressed: () async {
            // Wait for the button ink well splash to finish.
            await Future.delayed(const Duration(milliseconds: 300));
            widget.onDismiss(_hideTexts);
          },
          child: const Text("PLAY"),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xbf0d4645),
          ),
        ),
      ],
    );
  }

  Widget _buildPuzzlePiece(Piece piece) {
    return IgnorePointer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BoardConfig(
          unitSize: 30,
          hideTexts: _hideTexts,
          child: Stack(
            children: [
              PuzzlePieceShadow(piece: piece),
              PuzzlePieceAttachment(piece: piece),
              PuzzlePiece(piece: piece, disableGestures: true),
            ],
          ),
        ),
      ),
    );
  }
}
