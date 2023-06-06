import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class DialogHelper {
  //toast success
  static void showSuccessToast(BuildContext context,
      {String title = 'Sukses!',
      String description = 'Data berhasil terkirim'}) {
    CherryToast.success(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
      toastPosition: Position.bottom,
      borderRadius: 9,
      displayCloseButton: false,
      animationDuration: const Duration(milliseconds: 700),
    ).show(context);
  }

  //toast error
  static void showErrorToast(BuildContext context,
      {String title = 'Oops!',
      String description = 'Ada sesuatu yang salah, coba lagi'}) {
    CherryToast.error(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
      toastPosition: Position.bottom,
      borderRadius: 9,
      displayCloseButton: false,
      animationDuration: const Duration(milliseconds: 700),
    ).show(context);
  }

  //empty field
  static void showErrorFieldToast(BuildContext context,
      {String title = 'Terdapat field kosong',
      String description = 'Semua field diperlukan untuk menambahkan data'}) {
    CherryToast.error(
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      description: Text(
        description,
        style: const TextStyle(fontSize: 14),
      ),
      toastPosition: Position.bottom,
      borderRadius: 9,
      displayCloseButton: false,
      animationDuration: const Duration(milliseconds: 700),
    ).show(context);
  }
}
