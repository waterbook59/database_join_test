import 'dart:async';
import 'dart:io'; // 追加
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';//basename使うために追加
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';//TextEditingControllerを引数として渡してるので

class FileController {
  // ドキュメントのパスを取得
  static Future get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // 画像をドキュメントへ保存する。
  // 引数にはカメラ撮影時にreturnされるFileオブジェクトを持たせる。
//  static Future saveLocalImage(File image) async {
//    final dynamic path = await localPath;
//    final imagePath = '$path/image.png';
//    File imageFile = File(imagePath);
//    // カメラで撮影した画像は撮影時用の一時的フォルダパスに保存されるため、
//    // その画像をドキュメントへ保存し直す。
//    var savedFile = await imageFile.writeAsBytes(await image.readAsBytes());
//    // もしくは
//    // var savedFile = await image.copy(imagePath);
//    // でもOK
//
//    return savedFile;
//  }

  //todo 保存ボタン押した時に_imageがnullの時のバリデーション
  //todo 削除する時に便利なのでキャッシュのパスもDB保存しておく or DB保存時キャッシュ削除
  static Future<File> saveCachedImage(File image) async {
    final dynamic path = await localPath; //directory.path
    // =>DB保存側のパス：/data/user/0/com.example.datebasejointest/app_flutter
    ///file名(image.png)のところは、var fileName =basename(file.path)として、末尾だけを使ってファイル名付けられる
    ///import 'package:path/path.dart';必須
    ///例：file = File("/dir1/dir2/file.ext")=>basename(file)=>file.extだけ抽出できる
    ///File imageFile = await image.copy($path/$fileName);としても良いかも
    ///参照：https://python5.com/q/obnkujjk
    ///参照：https://stackoverflow.com/questions/50439949/flutter-get-the-filename-of-a-file
    final String fileName = basename(image.path);
    final String imagePath = '$path/$fileName';
    final File localImage = await image.copy(imagePath);
    print('キャッシュのパスかも：$image');
    print('path(localPath)の値：$path');
    print('fileName /basename(image.path);の値：$fileName');
    print('DB保存するlocalImage/image.copy(imagePath)の値：$localImage');
    return localImage;
//    final String key = controller.text;
//    /// localImageをlocalImage.pathとしてDBにString保存(今回はsharedPreferences)
//    final prefs = await SharedPreferences.getInstance();
//    prefs.setString(key, localImage.path);

  }

  ///cacheフォルダとローカルフォルダ(flutter_assets)のデータを削除
  static Future<void> deleteCashedImage(File deleteFile) async {
  print('deleteFileの中身:$deleteFile');
  //ローカルフォルダ削除
  await deleteFile.delete();
  //todo キャッシュも消したい

  }



}