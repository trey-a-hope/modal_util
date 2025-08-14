part of '../modal_util.dart';

class InputMatchConfirmationWidget extends StatefulWidget {
  final String title;
  final String hintText;
  final String match;

  const InputMatchConfirmationWidget({
    super.key,
    required this.title,
    required this.hintText,
    required this.match,
  });

  @override
  State<InputMatchConfirmationWidget> createState() =>
      _InputMatchConfirmationWidget();
}

class _InputMatchConfirmationWidget
    extends State<InputMatchConfirmationWidget> {
  final _textEditingController = TextEditingController();
  var _isButtonEnabled = false;

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
  Widget build(BuildContext context) =>
      UniversalPlatform.isIOS || UniversalPlatform.isMacOS
      ? _cupertinoAlertDialog()
      : _alertDialog();

  CupertinoAlertDialog _cupertinoAlertDialog() => CupertinoAlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _textEditingController,
      decoration: InputDecoration(hintText: widget.hintText),
    ),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: false,
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('NO'),
      ),
      CupertinoDialogAction(
        isDefaultAction: true,
        onPressed: () =>
            _isButtonEnabled ? Navigator.of(context).pop(true) : null,
        child: const Text('YES'),
      ),
    ],
  );

  AlertDialog _alertDialog() => AlertDialog(
    title: Text(widget.title),
    content: TextField(
      controller: _textEditingController,
      decoration: InputDecoration(hintText: widget.hintText),
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('NO', style: TextStyle(color: Colors.black)),
      ),
      ElevatedButton(
        onPressed: () =>
            _isButtonEnabled ? Navigator.of(context).pop(true) : null,
        child: const Text('YES', style: TextStyle(color: Colors.black)),
      ),
    ],
  );
}
