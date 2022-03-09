import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorWrapper extends StatelessWidget {
  const ErrorWrapper(
    this.error,
    this.stackTrace, {
    Key? key,
  }) : super(key: key);

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    debugPrintStack(
      label: error.toString(),
      stackTrace: stackTrace,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/image/undraw_startled.svg',
            width: MediaQuery.of(context).size.width * 0.64,
          ),
          const SizedBox(height: 16),
          Text(
            'Something Wrong',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Theme.of(context).errorColor,
                ),
          ),
          const SizedBox(height: 32),
          TextButton(
            child: const Text('Another'),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    actionsAlignment: MainAxisAlignment.center,
                    content: SingleChildScrollView(
                      child: Text(
                        error.toString(),
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: const Text('Copy'),
                        onPressed: () => Clipboard.setData(
                          ClipboardData(
                            text: '$error',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
