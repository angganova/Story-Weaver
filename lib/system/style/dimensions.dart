import 'package:flutter/material.dart';

///
/// Created computed spacing values for padding and margin.
///
/// 1. To create general spacing in [EdgeInsets], use
///   `kSpacer.edgeInsets.[side].[size]`
///
///     * Single-Side EdgeInsets: `kSpacer.edgeInsets.bottom.xxs`
///         = `EdgeInsets.only(bottom: 4.0)`
///
///     * Horizontal EdgeInsets: `kSpacer.edgeInsets.x.xs`
///         = `EdgeInsets.symmetric(horizontal: 8.0)`
///
///     * Vertical EdgeInsets: `kSpacer.edgeInsets.y.sm`
///         = `EdgeInsets.symmetric(vertical: 16.0)`
///
///     * All-Side EdgeInsets: `kSpacer.edgeInsets.all.xl`
///         = `EdgeInsets.all(48.0)`
///
/// 2. To create symmetric spacing in [EdgeInsets], use
///   `kSpacer.edgeInsets.symmetric(x: [size], y: [size])`
///
///     * `kSpacer.edgeInsets.symmetric(x: 'md', y: 'lg')`
///         = `EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0)`
///
/// 3. To create only-side spacing in [EdgeInsets], use
///   `kSpacer.edgeInsets.only([side]: [size], [side]: [size])`
///
///     * `kSpacer.edgeInsets.only(left: 'md', bottom: 'lg')`
///         = `EdgeInsets.only(left: 32.0, bottom: 40.0)`
///
/// 4. To create spacing in [double], use `kSpacer.[size]`
///
///     * double value: `kSpacer.xxl`
///         = 56.0
///
/// Available Options:
/// [side] : [left], [right], [top], [bottom], [x]=horizontal, [y]=vertical
/// [indicatorSize] : [none]=0, [xxs]=4, [xs]=8, [sm]=16, [md]=32, [lg]=40
/// [xl]=48, [xxl]=56, [standard]=24

///
/// Global grid spacer unit value
double kGridSpacer = 4.0;

///
/// This injects the grid spacer value to [Dimensions]
AppSpacer kSpacer = AppSpacer();

///
/// This helps in getting the factor for each of the specification
///
/// this gets to [none] = *0, [xxs] = *1, etc.
const Map<String, double> _helper = <String, double>{
  'none': 0,
  'xxxs': 0.5,
  'xxs': 1,
  'xxsm': 1.5,
  'xs': 2,
  's': 3,
  'sm': 4,
  'smd': 4.5,
  'md': 8,
  'lg': 10,
  'xl': 12,
  'xxl': 14,
  'xxxl': 16,
  'xxxxl': 26,
  'standard': 6,
};

///
/// This is the global dimensions class
///
/// with functions to compute spacing in [EdgeInsets] and [double].
class AppSpacer {
  factory AppSpacer() => instance;

  AppSpacer._() {
    spacerValue ??= kGridSpacer;
    edgeInsets = DimensionEdgeInsets(spacerValue!);
  }

  ///Singleton factory
  static final AppSpacer instance = AppSpacer._();

  double? spacerValue;
  late DimensionEdgeInsets edgeInsets;

  /// value: 0
  double get none => spacerValue! * _helper['none']!;

  /// value: 2
  double get xxxs => spacerValue! * _helper['xxxs']!;

  /// value: 4
  double get xxs => spacerValue! * _helper['xxs']!;

  /// value: 8
  double get xs => spacerValue! * _helper['xs']!;

  /// value: 12
  double get s => spacerValue! * _helper['s']!;

  /// value: 16
  double get sm => spacerValue! * _helper['sm']!;

  /// value: 18
  double get smd => spacerValue! * _helper['smd']!;

  /// value: 24
  double get standard => spacerValue! * 6;

  /// value: 32
  double get md => spacerValue! * _helper['md']!;

  /// value: 40
  double get lg => spacerValue! * _helper['lg']!;

  /// value: 48
  double get xl => spacerValue! * _helper['xl']!;

  /// value: 56
  double get xxl => spacerValue! * _helper['xxl']!;

  /// value: 64
  double get xxxl => spacerValue! * _helper['xxxl']!;

  /// value: 104
  double get xxxxl => spacerValue! * _helper['xxxxl']!;

  Widget get vNone => const SizedBox(height: 0, width: 0);
  Widget get vHstandard => SizedBox(height: standard, width: 0);
  Widget get vHxxxs => SizedBox(height: xxxs, width: 0);
  Widget get vHxxs => SizedBox(height: xxs, width: 0);
  Widget get vHxs => SizedBox(height: xs, width: 0);
  Widget get vHs => SizedBox(height: s, width: 0);
  Widget get vHsm => SizedBox(height: sm, width: 0);
  Widget get vHsmd => SizedBox(height: smd, width: 0);
  Widget get vHmd => SizedBox(height: md, width: 0);
  Widget get vHlg => SizedBox(height: lg, width: 0);
  Widget get vHxl => SizedBox(height: xl, width: 0);
  Widget get vHxxl => SizedBox(height: xxl, width: 0);
  Widget get vHxxxl => SizedBox(height: xxxl, width: 0);
  Widget get vHxxxxl => SizedBox(height: xxxxl, width: 0);

  /// Free Height Style
  Widget vHFreeStyle(double? height) => Container(height: height);

  Widget get vWstandard => SizedBox(width: standard, height: 0);
  Widget get vWxxxs => SizedBox(width: xxxs, height: 0);
  Widget get vWxxs => SizedBox(width: xxs, height: 0);
  Widget get vWxs => SizedBox(width: xs, height: 0);
  Widget get vWs => SizedBox(width: s, height: 0);
  Widget get vWsm => SizedBox(width: sm, height: 0);
  Widget get vWsmd => SizedBox(width: smd, height: 0);
  Widget get vWmd => SizedBox(width: md, height: 0);
  Widget get vWlg => SizedBox(width: lg, height: 0);
  Widget get vWxl => SizedBox(width: xl, height: 0);
  Widget get vWxxl => SizedBox(width: xxl, height: 0);
  Widget get vWxxxl => SizedBox(width: xxxl, height: 0);
  Widget get vWxxxxl => SizedBox(width: xxxxl, height: 0);

  /// Free Width Style
  Widget vWFreeStyle(double? width) => Container(width: width);
}

///
/// Customized EdgeInsets class
///
/// which includes manipulation of the sides
/// [left], [right], [top], [bottom]
/// [x] - left & right, [y] - top & bottom
/// [all] - left, right, top & bottom
class DimensionEdgeInsets {
  DimensionEdgeInsets(this.spacerValue) {
    _left = DimensionSide(spacerValue, SidesFlag(1, 0, 0, 0));
    _top = DimensionSide(spacerValue, SidesFlag(0, 1, 0, 0));
    _right = DimensionSide(spacerValue, SidesFlag(0, 0, 1, 0));
    _bottom = DimensionSide(spacerValue, SidesFlag(0, 0, 0, 1));
    _x = DimensionSide(spacerValue, SidesFlag(1, 0, 1, 0));
    _y = DimensionSide(spacerValue, SidesFlag(0, 1, 0, 1));
    _all = DimensionSide(spacerValue, SidesFlag(1, 1, 1, 1));
  }

  final double spacerValue;
  DimensionSide? _left;
  DimensionSide? _top;
  DimensionSide? _right;
  DimensionSide? _bottom;
  DimensionSide? _x;
  DimensionSide? _y;
  DimensionSide? _all;

  DimensionSide get left => _left!;

  DimensionSide get top => _top!;

  DimensionSide get right => _right!;

  DimensionSide get bottom => _bottom!;

  DimensionSide get x => _x!;

  DimensionSide get y => _y!;

  DimensionSide get all => _all!;

  EdgeInsets get zero => EdgeInsets.zero;

  EdgeInsets symmetric({String? x, String? y}) {
    validateHelperKey(x);
    validateHelperKey(y);
    return DimensionSize(
      spacerValue,
      SidesFlag(1, 1, 1, 1),
      x == null ? _helper['none'] : _helper[x],
      y == null ? _helper['none'] : _helper[y],
      x == null ? _helper['none'] : _helper[x],
      y == null ? _helper['none'] : _helper[y],
    ).data;
  }

  EdgeInsets only({String? left, String? top, String? right, String? bottom}) {
    validateHelperKey(left);
    validateHelperKey(top);
    validateHelperKey(right);
    validateHelperKey(bottom);

    return DimensionSize(
      spacerValue,
      SidesFlag(
        left == null ? 0 : 1,
        top == null ? 0 : 1,
        right == null ? 0 : 1,
        bottom == null ? 0 : 1,
      ),
      left == null ? _helper['none'] : _helper[left],
      top == null ? _helper['none'] : _helper[top],
      right == null ? _helper['none'] : _helper[right],
      bottom == null ? _helper['none'] : _helper[bottom],
    ).data;
  }

  void validateHelperKey(String? keyName) {
    if (keyName != null && !_helper.containsKey(keyName)) {
      throw 'Size name "$keyName" is not in the list. Check _Helper class.';
    }
  }
}

///
/// This gets us the actual side and manipulate it according to the size
///
/// this gets to
/// [spacer] - grid spacer value,
/// [sidesFlag] - left, right, top & bottom (all 4)
class DimensionSide {
  DimensionSide(this.spacer, this.sidesFlag);

  double spacer;
  SidesFlag sidesFlag;

  /// value: 0
  EdgeInsets get none {
    return DimensionSize(spacer, sidesFlag, _helper['none']).data;
  }

  /// value: 2
  EdgeInsets get xxxs {
    return DimensionSize(spacer, sidesFlag, _helper['xxxs']).data;
  }

  /// value: 4
  EdgeInsets get xxs {
    return DimensionSize(spacer, sidesFlag, _helper['xxs']).data;
  }

  EdgeInsets get xxsm {
    return DimensionSize(spacer, sidesFlag, _helper['xxsm']).data;
  }

  /// value: 8
  EdgeInsets get xs {
    return DimensionSize(spacer, sidesFlag, _helper['xs']).data;
  }

  /// value: 12
  EdgeInsets get s {
    return DimensionSize(spacer, sidesFlag, _helper['s']).data;
  }

  /// value: 16
  EdgeInsets get sm {
    return DimensionSize(spacer, sidesFlag, _helper['sm']).data;
  }

  /// value: 24
  EdgeInsets get standard {
    return DimensionSize(spacer, sidesFlag, _helper['standard']).data;
  }

  /// value: 32
  EdgeInsets get md {
    return DimensionSize(spacer, sidesFlag, _helper['md']).data;
  }

  /// value: 40
  EdgeInsets get lg {
    return DimensionSize(spacer, sidesFlag, _helper['lg']).data;
  }

  /// value: 48
  EdgeInsets get xl {
    return DimensionSize(spacer, sidesFlag, _helper['xl']).data;
  }

  /// value: 56
  EdgeInsets get xxl {
    return DimensionSize(spacer, sidesFlag, _helper['xxl']).data;
  }

  /// value: 64
  EdgeInsets get xxxl {
    return DimensionSize(spacer, sidesFlag, _helper['xxxl']).data;
  }

  /// value: 80
  EdgeInsets get xxxxl {
    return DimensionSize(spacer, sidesFlag, _helper['xxxxl']).data;
  }
}

///
/// This actually does the calculation according to the spacer, sides & factor
///
/// this gets to
/// [spacer] - grid spacer value,
/// [sidesFlag] - left, right, top & bottom (all 4)
/// [factor] - none, xxs, xs, sm, md, lg, xl, xxl (Helper class)
class DimensionSize {
  DimensionSize(this.spacer, this.sidesFlag, this.factorL,
      [this.factorT, this.factorR, this.factorB]) {
    factorT ??= factorL;
    factorR ??= factorL;
    factorB ??= factorL;
  }

  double spacer;
  SidesFlag sidesFlag;
  double? factorL; // Left side
  double? factorT; // Top side
  double? factorR; // Right side
  double? factorB; // Bottom side

  EdgeInsets get data => EdgeInsets.fromLTRB(
        sidesFlag.leftFlag * spacer * factorL!,
        sidesFlag.topFlag * spacer * factorT!,
        sidesFlag.rightFlag * spacer * factorR!,
        sidesFlag.bottomFlag * spacer * factorB!,
      );
}

///
/// This sets the value of the sides
///
/// this includes:
/// [left], [right], [top] & [bottom]
class SidesFlag {
  SidesFlag(this.leftFlag, this.topFlag, this.rightFlag, this.bottomFlag);

  double leftFlag = 0;
  double topFlag = 0;
  double rightFlag = 0;
  double bottomFlag = 0;
}
