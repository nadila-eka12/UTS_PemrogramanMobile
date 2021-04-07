import 'package:flutter/material.dart';
import 'Deskripsi.dart';

class Deskripsi {
  int _nomorHp;
  int _hargaHp;
  String _merkHp;
  String _deskripsiHp;

  int get nomorHp => _nomorHp;
  int get hargaHp => this._hargaHp;
  set hargaHp(int value) => this._hargaHp = value;
  String get merkHp => this._merkHp;
  set merkHp(String value) => this._merkHp = value;
  String get deskripsiHp => this._deskripsiHp;
  set deskripsiHp(String value) => this._deskripsiHp = value;

// konstruktor versi 1
  Deskripsi(this._hargaHp, this._merkHp, this._deskripsiHp);

  // konstruktor versi 2: konversi dari Map ke Item
  Deskripsi.fromMap(Map<String, dynamic> map) {
    this._nomorHp = map['nomor'];
    this._hargaHp = map['harga'];
    this._merkHp = map['merkHp'];
    this._deskripsiHp = map['deskripsi'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['nomor'] = this._nomorHp;
    map['harga'] = hargaHp;
    map['merkHp'] = merkHp;
    map['deskripsiHp'] = deskripsiHp;
    return map;
  }
}
