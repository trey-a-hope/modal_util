part of '../modal_util.dart';

class InputMatchConfirmationWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final String match;
  final void Function()? onNoPressed;
  final void Function()? onYesPressed;

  const InputMatchConfirmationWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.match,
    required this.onNoPressed,
    required this.onYesPressed,
  });

  @override
  State<InputMatchConfirmationWidget> createState() =>
      _InputMatchConfirmationWidget();
}

class _InputMatchConfirmationWidget
    extends State<InputMatchConfirmationWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(
      () => setState(
        () => _isButtonEnabled = _textEditingController.text == widget.match,
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Platform.isIOS
      ? CupertinoAlertDialog(
          title: Text(widget.title),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: false,
              onPressed: widget.onNoPressed,
              child: const Text('NO'),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => _isButtonEnabled ? widget.onYesPressed : null,
              child: const Text('YES'),
            ),
          ],
        )
      : AlertDialog(
          title: Text(widget.title),
          content: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(hintText: widget.hintText),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: widget.onNoPressed,
              child: const Text('NO', style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              onPressed: () => _isButtonEnabled ? widget.onYesPressed : null,
              child: const Text('YES', style: TextStyle(color: Colors.black)),
            ),
          ],
        );
}
