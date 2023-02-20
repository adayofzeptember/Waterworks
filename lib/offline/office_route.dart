import 'package:flutter/material.dart';
import 'package:waterworks/offline/page_offline.dart';
import 'package:waterworks/offline/search_page.dart';

Route pageOffice() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return PageOffline();
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1,
            end: 1,
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        ),
      );
    },
    transitionDuration: const Duration(
      milliseconds: 350,
    ),
  );
}

Route searchPage() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return SearchPage();
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1,
            end: 1,
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        ),
      );
    },
    transitionDuration: const Duration(
      milliseconds: 350,
    ),
  );
}
