import 'dart:async';

class ServiceDebounce {
  ///timer for debounce
  ///
  static Timer? debounce;

  static call({Function? function}) async {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: 350), () {
      function!();
      debounce!.cancel();
    });
  }
}
