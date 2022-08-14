import 'dart:typed_data';

import 'sp3d_face.dart';
import 'sp3d_fragment.dart';
import 'sp3d_material.dart';
import 'sp3d_physics.dart';
import 'sp3d_v3d.dart';

///
/// (en) Flutter implementation of Sp3dObj.
/// The options for this object and internal elements can be freely extended for each application.
/// When writing out, toDict is converted to json. If you want to read it, you can easily restore it by calling fromDict.
///
/// (ja) Sp3dObjのFlutter実装です。
/// このオブジェクト及び内部要素のoptionはアプリケーション毎に自由に拡張できます。
/// 書きだす場合はtoDictしたものをjson化します。読み込む場合はfromDict呼び出しで簡単に復元できます。
///
/// Author Masahide Mori
///
/// First edition creation date 2021-06-30 22:54:22
///
class Sp3dObj {
  final String className = 'Sp3dObj';
  final String version = '7';
  List<Sp3dV3D> vertices;
  List<Sp3dFragment> fragments;
  List<Sp3dMaterial> materials;
  List<Uint8List> images;
  String? id;
  String? name;
  String? author;
  Sp3dPhysics? physics;
  Map<String, dynamic>? option;

  /// Constructor
  /// * [vertices] : vertex list.
  /// * [fragments] : This includes information such as the vertex information of the object.
  /// * [materials] : This includes information such as colors.
  /// * [images] : Image data.
  /// * [id] : Object ID.
  /// * [name] : Object name.
  /// * [author] : Object author name. It is mainly for distribution, and null is better during calculation.
  /// * [physics] : Parameters for physics calculations.
  /// * [option] : Optional attributes that may be added for each app.
  Sp3dObj(this.vertices, this.fragments, this.materials, this.images,
      {this.id, this.name, this.author, this.physics, this.option});

  /// Deep copy the object.
  Sp3dObj deepCopy() {
    List<Sp3dV3D> v = [];
    for (var i in vertices) {
      v.add(i.deepCopy());
    }
    List<Sp3dFragment> frgs = [];
    for (var i in fragments) {
      frgs.add(i.deepCopy());
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in materials) {
      mtrs.add(i.deepCopy());
    }
    List<Uint8List> imgs = [];
    for (Uint8List i in images) {
      List<int> il = [];
      for (var j in i) {
        il.add(j);
      }
      imgs.add(Uint8List.fromList(il));
    }
    return Sp3dObj(v, frgs, mtrs, imgs,
        id: id,
        name: name,
        author: author,
        physics: physics != null ? physics!.deepCopy() : null,
        option: option != null ? {...option!} : null);
  }

  /// Convert the object to a dictionary.
  Map<String, dynamic> toDict() {
    Map<String, dynamic> d = {};
    d['class_name'] = className;
    d['version'] = version;
    List<Map<String, dynamic>> v = [];
    for (var i in vertices) {
      v.add(i.toDict());
    }
    d['vertices'] = v;
    List<Map<String, dynamic>> frgs = [];
    for (var i in fragments) {
      frgs.add(i.toDict());
    }
    d['fragments'] = frgs;
    List<Map<String, dynamic>> mtrs = [];
    for (var i in materials) {
      mtrs.add(i.toDict());
    }
    d['materials'] = mtrs;
    List<List<int>> imgs = [];
    for (Uint8List i in images) {
      List<int> il = [];
      for (var j in i) {
        il.add(j);
      }
      imgs.add(il);
    }
    d['images'] = imgs;
    d['id'] = id;
    d['name'] = name;
    d['author'] = author;
    d['physics'] = physics != null ? physics!.toDict() : null;
    d['option'] = option;
    return d;
  }

  /// Restore this object from the dictionary.
  /// * [src] : A dictionary made with toDict of this class.
  static Sp3dObj fromDict(Map<String, dynamic> src) {
    List<Sp3dV3D> v = [];
    for (var i in src['vertices']) {
      v.add(Sp3dV3D.fromDict(i));
    }
    List<Sp3dFragment> frgs = [];
    for (var i in src['fragments']) {
      frgs.add(Sp3dFragment.fromDict(i));
    }
    List<Sp3dMaterial> mtrs = [];
    for (var i in src['materials']) {
      mtrs.add(Sp3dMaterial.fromDict(i));
    }
    List<Uint8List> imgs = [];
    for (List<dynamic> i in src['images']) {
      List<int> iL = [];
      for (dynamic j in i) {
        iL.add(j as int);
      }
      imgs.add(Uint8List.fromList(iL));
    }
    return Sp3dObj(v, frgs, mtrs, imgs,
        id: src['id'],
        name: src['name'],
        author: src.containsKey('author') ? src['author'] : null,
        physics: src.containsKey('physics')
            ? src['physics'] != null
                ? Sp3dPhysics.fromDict(src['physics'])
                : null
            : null,
        option: src['option']);
  }

  /// (en)Adds the specified vector to all vectors of this object.
  ///
  /// (ja)このオブジェクトの全てのベクトルに指定したベクトルを加算します。
  ///
  /// * [v] : vector.
  Sp3dObj move(Sp3dV3D v) {
    for (Sp3dV3D i in vertices) {
      i.add(v);
    }
    return this;
  }

  /// (en)Rotates all vectors of this object based on the specified axis.
  ///
  /// (ja)このオブジェクトの全てのベクトルを指定した軸をベースに回転させます。
  ///
  /// * [norAxis] : normalized rotate axis vector.
  /// * [radian] : radian = degree * pi / 180.
  Sp3dObj rotate(Sp3dV3D norAxis, double radian) {
    for (Sp3dV3D i in vertices) {
      i.rotate(norAxis, radian);
    }
    return this;
  }

  /// (en)Merge another object into this object. This operation is high cost.
  /// id, name, author, physics and option values do not change.
  ///
  /// (ja)このオブジェクトに別のオブジェクトをマージします。この操作は高コストです。
  /// このオブジェクト固有のパラメータ（id,name,author,physics）とオプション値は変更されません。
  ///
  /// * [other] : other obj.
  Sp3dObj merge(Sp3dObj other) {
    Sp3dObj copyOther = other.deepCopy();
    // 追加する各要素のインデックスを変更。
    final int myVerticesLen = vertices.length;
    final int myMaterialLen = materials.length;
    final int myImageLen = images.length;
    for (Sp3dMaterial i in copyOther.materials) {
      if (i.imageIndex != null) {
        i.imageIndex = i.imageIndex! + myImageLen;
      }
    }
    for (Sp3dFragment i in copyOther.fragments) {
      for (Sp3dFace j in i.faces) {
        if (j.materialIndex != null) {
          j.materialIndex = j.materialIndex! + myMaterialLen;
        }
        for (int k = 0; k < j.vertexIndexList.length; k++) {
          j.vertexIndexList[k] += myVerticesLen;
        }
      }
    }
    // 追加
    for (Uint8List i in copyOther.images) {
      images.add(i);
    }
    for (Sp3dMaterial i in copyOther.materials) {
      materials.add(i);
    }
    for (Sp3dV3D i in copyOther.vertices) {
      vertices.add(i);
    }
    for (Sp3dFragment i in copyOther.fragments) {
      fragments.add(i);
    }
    return this;
  }

  /// (en)Gets the average coordinates of this object.
  ///
  /// (ja)このオブジェクトの平均座標を取得します。
  Sp3dV3D getCenter() {
    return Sp3dV3D.ave(vertices);
  }
}
