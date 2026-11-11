Warning: truncated output (original token count: 64027)
Total output lines: 6808

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectValue<T> {

 T get value;
/// Create a copy of SelectValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectValueCopyWith<T, SelectValue<T>> get copyWith => _$SelectValueCopyWithImpl<T, SelectValue<T>>(this as SelectValue<T>, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SelectValue<T>;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectValue<T>&&const DeepCollectionEquality().equals(other.value, _this.value));
}


@override
int get hashCode {
  final _this = this as SelectValue<T>;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.value));
}

@override
String toString() {
  final _this = this as SelectValue<T>;
  return 'SelectValue<$T>(value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $SelectValueCopyWith<T,$Res>  {
  factory $SelectValueCopyWith(SelectValue<T> value, $Res Function(SelectValue<T>) _then) = _$SelectValueCopyWithImpl;
@useResult
$Res call({
 T value
});




}
/// @nodoc
class _$SelectValueCopyWithImpl<T,$Res>
    implements $SelectValueCopyWith<T, $Res> {
  _$SelectValueCopyWithImpl(this._self, this._then);

  final SelectValue<T> _self;
  final $Res Function(SelectValue<T>) _then;

/// Create a copy of SelectValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = freezed,}) {
  return _then(SelectValue(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectValue].
extension SelectValuePatterns<T> on SelectValue<T> {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectValue<T> value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectValue() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectValue<T> value)  $default,){
final _that = this;
switch (_that) {
case _SelectValue():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectValue<T> value)?  $default,){
final _that = this;
switch (_that) {
case _SelectValue() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( T value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectValue() when $default != null:
return $default(_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( T value)  $default,) {final _that = this;
switch (_that) {
case _SelectValue():
return $default(_that.value);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( T value)?  $default,) {final _that = this;
switch (_that) {
case _SelectValue() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _SelectValue<T> implements SelectValue<T> {
  const _SelectValue(this.value);
  

@override final  T value;

/// Create a copy of SelectValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectValueCopyWith<T, _SelectValue<T>> get copyWith => __$SelectValueCopyWithImpl<T, _SelectValue<T>>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectValue<T>&&const DeepCollectionEquality().equals(other.value, value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(value));
}

@override
String toString() {
    return 'SelectValue<$T>(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SelectValueCopyWith<T,$Res> implements $SelectValueCopyWith<T, $Res> {
  factory _$SelectValueCopyWith(_SelectValue<T> value, $Res Function(_SelectValue<T>) _then) = __$SelectValueCopyWithImpl;
@override @useResult
$Res call({
 T value
});




}
/// @nodoc
class __$SelectValueCopyWithImpl<T,$Res>
    implements _$SelectValueCopyWith<T, $Res> {
  __$SelectValueCopyWithImpl(this._self, this._then);

  final _SelectValue<T> _self;
  final $Res Function(_SelectValue<T>) _then;

/// Create a copy of SelectValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = freezed,}) {
  return _then(_SelectValue<T>(
freezed == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as T,
  ));
}


}

/// @nodoc
mixin _$ProfilesState {

 List<Profile> get profiles; int? get currentProfileId;
/// Create a copy of ProfilesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilesStateCopyWith<ProfilesState> get copyWith => _$ProfilesStateCopyWithImpl<ProfilesState>(this as ProfilesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProfilesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilesState&&const DeepCollectionEquality().equals(other.profiles, _this.profiles)&&(identical(other.currentProfileId, _this.currentProfileId) || other.currentProfileId == _this.currentProfileId));
}


@override
int get hashCode {
  final _this = this as ProfilesState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.profiles),_this.currentProfileId);
}

@override
String toString() {
  final _this = this as ProfilesState;
  return 'ProfilesState(profiles: ${_this.profiles}, currentProfileId: ${_this.currentProfileId})';
}


}

/// @nodoc
abstract mixin class $ProfilesStateCopyWith<$Res>  {
  factory $ProfilesStateCopyWith(ProfilesState value, $Res Function(ProfilesState) _then) = _$ProfilesStateCopyWithImpl;
@useResult
$Res call({
 List<Profile> profiles, int? currentProfileId
});




}
/// @nodoc
class _$ProfilesStateCopyWithImpl<$Res>
    implements $ProfilesStateCopyWith<$Res> {
  _$ProfilesStateCopyWithImpl(this._self, this._then);

  final ProfilesState _self;
  final $Res Function(ProfilesState) _then;

/// Create a copy of ProfilesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profiles = null,Object? currentProfileId = freezed,}) {
  return _then(ProfilesState(
profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<Profile>,currentProfileId: freezed == currentProfileId ? _self.currentProfileId : currentProfileId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfilesState].
extension ProfilesStatePatterns on ProfilesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfilesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfilesState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfilesState value)  $default,){
final _that = this;
switch (_that) {
case _ProfilesState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfilesState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfilesState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Profile> profiles,  int? currentProfileId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfilesState() when $default != null:
return $default(_that.profiles,_that.currentProfileId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Profile> profiles,  int? currentProfileId)  $default,) {final _that = this;
switch (_that) {
case _ProfilesState():
return $default(_that.profiles,_that.currentProfileId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Profile> profiles,  int? currentProfileId)?  $default,) {final _that = this;
switch (_that) {
case _ProfilesState() when $default != null:
return $default(_that.profiles,_that.currentProfileId);case _:
  return null;

}
}

}

/// @nodoc


class _ProfilesState implements ProfilesState {
  const _ProfilesState({required  List<Profile> profiles, required this.currentProfileId}): _profiles = profiles;
  

 final  List<Profile> _profiles;
@override List<Profile> get profiles {
  if (_profiles is EqualUnmodifiableListView) return _profiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profiles);
}

@override final  int? currentProfileId;

/// Create a copy of ProfilesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfilesStateCopyWith<_ProfilesState> get copyWith => __$ProfilesStateCopyWithImpl<_ProfilesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfilesState&&const DeepCollectionEquality().equals(other.profiles, _profiles)&&(identical(other.currentProfileId, currentProfileId) || other.currentProfileId == currentProfileId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_profiles),currentProfileId);
}

@override
String toString() {
    return 'ProfilesState(profiles: $profiles, currentProfileId: $currentProfileId)';
}


}

/// @nodoc
abstract mixin class _$ProfilesStateCopyWith<$Res> implements $ProfilesStateCopyWith<$Res> {
  factory _$ProfilesStateCopyWith(_ProfilesState value, $Res Function(_ProfilesState) _then) = __$ProfilesStateCopyWithImpl;
@override @useResult
$Res call({
 List<Profile> profiles, int? currentProfileId
});




}
/// @nodoc
class __$ProfilesStateCopyWithImpl<$Res>
    implements _$ProfilesStateCopyWith<$Res> {
  __$ProfilesStateCopyWithImpl(this._self, this._then);

  final _ProfilesState _self;
  final $Res Function(_ProfilesState) _then;

/// Create a copy of ProfilesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profiles = null,Object? currentProfileId = freezed,}) {
  return _then(_ProfilesState(
profiles: null == profiles ? _self._profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<Profile>,currentProfileId: freezed == currentProfileId ? _self.currentProfileId : currentProfileId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$TrayState {

 Mode get mode; int get port; bool get autoLaunch; bool get systemProxy; bool get tunEnable; bool get isStart; bool get suspended; List<Group> get groups; Map<String, String> get selectedMap; bool get showTrayTitle; bool get monochromeTrayIcon; bool get safeMode; Map<HotAction, HotKeyAction> get hotKeys;
/// Create a copy of TrayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrayStateCopyWith<TrayState> get copyWith => _$TrayStateCopyWithImpl<TrayState>(this as TrayState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TrayState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrayState&&(identical(other.mode, _this.mode) || other.mode == _this.mode)&&(identical(other.port, _this.port) || other.port == _this.port)&&(identical(other.autoLaunch, _this.autoLaunch) || other.autoLaunch == _this.autoLaunch)&&(identical(other.systemProxy, _this.systemProxy) || other.systemProxy == _this.systemProxy)&&(identical(other.tunEnable, _this.tunEnable) || other.tunEnable == _this.tunEnable)&&(identical(other.isStart, _this.isStart) || other.isStart == _this.isStart)&&(identical(other.suspended, _this.suspended) || other.suspended == _this.suspended)&&const DeepCollectionEquality().equals(other.groups, _this.groups)&&const DeepCollectionEquality().equals(other.selectedMap, _this.selectedMap)&&(identical(other.showTrayTitle, _this.showTrayTitle) || other.showTrayTitle == _this.showTrayTitle)&&(identical(other.monochromeTrayIcon, _this.monochromeTrayIcon) || other.monochromeTrayIcon == _this.monochromeTrayIcon)&&(identical(other.safeMode, _this.safeMode) || other.safeMode == _this.safeMode)&&const DeepCollectionEquality().equals(other.hotKeys, _this.hotKeys));
}


@override
int get hashCode {
  final _this = this as TrayState;
  return Object.hash(runtimeType,_this.mode,_this.port,_this.autoLaunch,_this.systemProxy,_this.tunEnable,_this.isStart,_this.suspended,const DeepCollectionEquality().hash(_this.groups),const DeepCollectionEquality().hash(_this.selectedMap),_this.showTrayTitle,_this.monochromeTrayIcon,_this.safeMode,const DeepCollectionEquality().hash(_this.hotKeys));
}

@override
String toString() {
  final _this = this as TrayState;
  return 'TrayState(mode: ${_this.mode}, port: ${_this.port}, autoLaunch: ${_this.autoLaunch}, systemProxy: ${_this.systemProxy}, tunEnable: ${_this.tunEnable}, isStart: ${_this.isStart}, suspended: ${_this.suspended}, groups: ${_this.groups}, selectedMap: ${_this.selectedMap}, showTrayTitle: ${_this.showTrayTitle}, monochromeTrayIcon: ${_this.monochromeTrayIcon}, safeMode: ${_this.safeMode}, hotKeys: ${_this.hotKeys})';
}


}

/// @nodoc
abstract mixin class $TrayStateCopyWith<$Res>  {
  factory $TrayStateCopyWith(TrayState value, $Res Function(TrayState) _then) = _$TrayStateCopyWithImpl;
@useResult
$Res call({
 Mode mode, int port, bool autoLaunch, bool systemProxy, bool tunEnable, bool isStart, bool suspended, List<Group> groups, Map<String, String> selectedMap, bool showTrayTitle, bool monochromeTrayIcon, bool safeMode, Map<HotAction, HotKeyAction> hotKeys
});




}
/// @nodoc
class _$TrayStateCopyWithImpl<$Res>
    implements $TrayStateCopyWith<$Res> {
  _$TrayStateCopyWithImpl(this._self, this._then);

  final TrayState _self;
  final $Res Function(TrayState) _then;

/// Create a copy of TrayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mode = null,Object? port = null,Object? autoLaunch = null,Object? systemProxy = null,Object? tunEnable = null,Object? isStart = null,Object? suspended = null,Object? groups = null,Object? selectedMap = null,Object? showTrayTitle = null,Object? monochromeTrayIcon = null,Object? safeMode = null,Object? hotKeys = null,}) {
  return _then(TrayState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as Mode,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,autoLaunch: null == autoLaunch ? _self.autoLaunch : autoLaunch // ignore: cast_nullable_to_non_nullable
as bool,systemProxy: null == systemProxy ? _self.systemProxy : systemProxy // ignore: cast_nullable_to_non_nullable
as bool,tunEnable: null == tunEnable ? _self.tunEnable : tunEnable // ignore: cast_nullable_to_non_nullable
as bool,isStart: null == isStart ? _self.isStart : isStart // ignore: cast_nullable_to_non_nullable
as bool,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self.groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,selectedMap: null == selectedMap ? _self.selectedMap : selectedMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,showTrayTitle: null == showTrayTitle ? _self.showTrayTitle : showTrayTitle // ignore: cast_nullable_to_non_nullable
as bool,monochromeTrayIcon: null == monochromeTrayIcon ? _self.monochromeTrayIcon : monochromeTrayIcon // ignore: cast_nullable_to_non_nullable
as bool,safeMode: null == safeMode ? _self.safeMode : safeMode // ignore: cast_nullable_to_non_nullable
as bool,hotKeys: null == hotKeys ? _self.hotKeys : hotKeys // ignore: cast_nullable_to_non_nullable
as Map<HotAction, HotKeyAction>,
  ));
}

}


/// Adds pattern-matching-related methods to [TrayState].
extension TrayStatePatterns on TrayState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrayState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrayState value)  $default,){
final _that = this;
switch (_that) {
case _TrayState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrayState value)?  $default,){
final _that = this;
switch (_that) {
case _TrayState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Mode mode,  int port,  bool autoLaunch,  bool systemProxy,  bool tunEnable,  bool isStart,  bool suspended,  List<Group> groups,  Map<String, String> selectedMap,  bool showTrayTitle,  bool monochromeTrayIcon,  bool safeMode,  Map<HotAction, HotKeyAction> hotKeys)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrayState() when $default != null:
return $default(_that.mode,_that.port,_that.autoLaunch,_that.systemProxy,_that.tunEnable,_that.isStart,_that.suspended,_that.groups,_that.selectedMap,_that.showTrayTitle,_that.monochromeTrayIcon,_that.safeMode,_that.hotKeys);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Mode mode,  int port,  bool autoLaunch,  bool systemProxy,  bool tunEnable,  bool isStart,  bool suspended,  List<Group> groups,  Map<String, String> selectedMap,  bool showTrayTitle,  bool monochromeTrayIcon,  bool safeMode,  Map<HotAction, HotKeyAction> hotKeys)  $default,) {final _that = this;
switch (_that) {
case _TrayState():
return $default(_that.mode,_that.port,_that.autoLaunch,_that.systemProxy,_that.tunEnable,_that.isStart,_that.suspended,_that.groups,_that.selectedMap,_that.showTrayTitle,_that.monochromeTrayIcon,_that.safeMode,_that.hotKeys);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Mode mode,  int port,  bool autoLaunch,  bool systemProxy,  bool tunEnable,  bool isStart,  bool suspended,  List<Group> groups,  Map<String, String> selectedMap,  bool showTrayTitle,  bool monochromeTrayIcon,  bool safeMode,  Map<HotAction, HotKeyAction> hotKeys)?  $default,) {final _that = this;
switch (_that) {
case _TrayState() when $default != null:
return $default(_that.mode,_that.port,_that.autoLaunch,_that.systemProxy,_that.tunEnable,_that.isStart,_that.suspended,_that.groups,_that.selectedMap,_that.showTrayTitle,_that.monochromeTrayIcon,_that.safeMode,_that.hotKeys);case _:
  return null;

}
}

}

/// @nodoc


class _TrayState implements TrayState {
  const _TrayState({required this.mode, required this.port, required this.autoLaunch, required this.systemProxy, required this.tunEnable, required this.isStart, this.suspended = false, required  List<Group> groups, required  Map<String, String> selectedMap, required this.showTrayTitle, this.monochromeTrayIcon = true, required this.safeMode,  Map<HotAction, HotKeyAction> hotKeys = const {}}): _groups = groups,_selectedMap = selectedMap,_hotKeys = hotKeys;
  

@override final  Mode mode;
@override final  int port;
@override final  bool autoLaunch;
@override final  bool systemProxy;
@override final  bool tunEnable;
@override final  bool isStart;
@override@JsonKey() final  bool suspended;
 final  List<Group> _groups;
@override List<Group> get groups {
  if (_groups is EqualUnmodifiableListView) return _groups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_groups);
}

 final  Map<String, String> _selectedMap;
@override Map<String, String> get selectedMap {
  if (_selectedMap is EqualUnmodifiableMapView) return _selectedMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedMap);
}

@override final  bool showTrayTitle;
@override@JsonKey() final  bool monochromeTrayIcon;
@override final  bool safeMode;
 final  Map<HotAction, HotKeyAction> _hotKeys;
@override@JsonKey() Map<HotAction, HotKeyAction> get hotKeys {
  if (_hotKeys is EqualUnmodifiableMapView) return _hotKeys;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_hotKeys);
}


/// Create a copy of TrayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrayStateCopyWith<_TrayState> get copyWith => __$TrayStateCopyWithImpl<_TrayState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrayState&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.port, port) || other.port == port)&&(identical(other.autoLaunch, autoLaunch) || other.autoLaunch == autoLaunch)&&(identical(other.systemProxy, systemProxy) || other.systemProxy == systemProxy)&&(identical(other.tunEnable, tunEnable) || other.tunEnable == tunEnable)&&(identical(other.isStart, isStart) || other.isStart == isStart)&&(identical(other.suspended, suspended) || other.suspended == suspended)&&const DeepCollectionEquality().equals(other.groups, _groups)&&const DeepCollectionEquality().equals(other.selectedMap, _selectedMap)&&(identical(other.showTrayTitle, showTrayTitle) || other.showTrayTitle == showTrayTitle)&&(identical(other.monochromeTrayIcon, monochromeTrayIcon) || other.monochromeTrayIcon == monochromeTrayIcon)&&(identical(other.safeMode, safeMode) || other.safeMode == safeMode)&&const DeepCollectionEquality().equals(other.hotKeys, _hotKeys));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mode,port,autoLaunch,systemProxy,tunEnable,isStart,suspended,const DeepCollectionEquality().hash(_groups),const DeepCollectionEquality().hash(_selectedMap),showTrayTitle,monochromeTrayIcon,safeMode,const DeepCollectionEquality().hash(_hotKeys));
}

@override
String toString() {
    return 'TrayState(mode: $mode, port: $port, autoLaunch: $autoLaunch, systemProxy: $systemProxy, tunEnable: $tunEnable, isStart: $isStart, suspended: $suspended, groups: $groups, selectedMap: $selectedMap, showTrayTitle: $showTrayTitle, monochromeTrayIcon: $monochromeTrayIcon, safeMode: $safeMode, hotKeys: $hotKeys)';
}


}

/// @nodoc
abstract mixin class _$TrayStateCopyWith<$Res> implements $TrayStateCopyWith<$Res> {
  factory _$TrayStateCopyWith(_TrayState value, $Res Function(_TrayState) _then) = __$TrayStateCopyWithImpl;
@override @useResult
$Res call({
 Mode mode, int port, bool autoLaunch, bool systemProxy, bool tunEnable, bool isStart, bool suspended, List<Group> groups, Map<String, String> selectedMap, bool showTrayTitle, bool monochromeTrayIcon, bool safeMode, Map<HotAction, HotKeyAction> hotKeys
});




}
/// @nodoc
class __$TrayStateCopyWithImpl<$Res>
    implements _$TrayStateCopyWith<$Res> {
  __$TrayStateCopyWithImpl(this._self, this._then);

  final _TrayState _self;
  final $Res Function(_TrayState) _then;

/// Create a copy of TrayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? port = null,Object? autoLaunch = null,Object? systemProxy = null,Object? tunEnable = null,Object? isStart = null,Object? suspended = null,Object? groups = null,Object? selectedMap = null,Object? showTrayTitle = null,Object? monochromeTrayIcon = null,Object? safeMode = null,Object? hotKeys = null,}) {
  return _then(_TrayState(
mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as Mode,port: null == port ? _self.port : port // ignore: cast_nullable_to_non_nullable
as int,autoLaunch: null == autoLaunch ? _self.autoLaunch : autoLaunch // ignore: cast_nullable_to_non_nullable
as bool,systemProxy: null == systemProxy ? _self.systemProxy : systemProxy // ignore: cast_nullable_to_non_nullable
as bool,tunEnable: null == tunEnable ? _self.tunEnable : tunEnable // ignore: cast_nullable_to_non_nullable
as bool,isStart: null == isStart ? _self.isStart : isStart // ignore: cast_nullable_to_non_nullable
as bool,suspended: null == suspended ? _self.suspended : suspended // ignore: cast_nullable_to_non_nullable
as bool,groups: null == groups ? _self._groups : groups // ignore: cast_nullable_to_non_nullable
as List<Group>,selectedMap: null == selectedMap ? _self._selectedMap : selectedMap // ignore: cast_nullable_to_non_nullable
as Map<String, String>,showTrayTitle: null == showTrayTitle ? _self.showTrayTitle : showTrayTitle // ignore: cast_nullable_to_non_nullable
as bool,monochromeTrayIcon: null == monochromeTrayIcon ? _self.monochromeTrayIcon : monochromeTrayIcon // ignore: cast_nullable_to_non_nullable
as bool,safeMode: null == safeMode ? _self.safeMode : safeMode // ignore: cast_nullable_to_non_nullable
as bool,hotKeys: null == hotKeys ? _self._hotKeys : hotKeys // ignore: cast_nullable_to_non_nullable
as Map<HotAction, HotKeyAction>,
  ));
}


}

/// @nodoc
mixin _$TrayTitleState {

 Traffic get traffic; bool get showTrayTitle;
/// Create a copy of TrayTitleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrayTitleStateCopyWith<TrayTitleState> get copyWith => _$TrayTitleStateCopyWithImpl<TrayTitleState>(this as TrayTitleState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TrayTitleState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrayTitleState&&(identical(other.traffic, _this.traffic) || other.traffic == _this.traffic)&&(identical(other.showTrayTitle, _this.showTrayTitle) || other.showTrayTitle == _this.showTrayTitle));
}


@override
int get hashCode {
  final _this = this as TrayTitleState;
  return Object.hash(runtimeType,_this.traffic,_this.showTrayTitle);
}

@override
String toString() {
  final _this = this as TrayTitleState;
  return 'TrayTitleState(traffic: ${_this.traffic}, showTrayTitle: ${_this.showTrayTitle})';
}


}

/// @nodoc
abstract mixin class $TrayTitleStateCopyWith<$Res>  {
  factory $TrayTitleStateCopyWith(TrayTitleState value, $Res Function(TrayTitleState) _then) = _$TrayTitleStateCopyWithImpl;
@useResult
$Res call({
 Traffic traffic, bool showTrayTitle
});


$TrafficCopyWith<$Res> get traffic;

}
/// @nodoc
class _$TrayTitleStateCopyWithImpl<$Res>
    implements $TrayTitleStateCopyWith<$Res> {
  _$TrayTitleStateCopyWithImpl(this._self, this._then);

  final TrayTitleState _self;
  final $Res Function(TrayTitleState) _then;

/// Create a copy of TrayTitleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? traffic = null,Object? showTrayTitle = null,}) {
  return _then(TrayTitleState(
traffic: null == traffic ? _self.traffic : traffic // ignore: cast_nullable_to_non_nullable
as Traffic,showTrayTitle: null == showTrayTitle ? _self.showTrayTitle : showTrayTitle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of TrayTitleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrafficCopyWith<$Res> get traffic {
  
  return $TrafficCopyWith<$Res>(_self.traffic, (value) {
    return _then(_self.copyWith(traffic: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrayTitleState].
extension TrayTitleStatePatterns on TrayTitleState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrayTitleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrayTitleState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrayTitleState value)  $default,){
final _that = this;
switch (_that) {
case _TrayTitleState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrayTitleState value)?  $default,){
final _that = this;
switch (_that) {
case _TrayTitleState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Traffic traffic,  bool showTrayTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrayTitleState() when $default != null:
return $default(_that.traffic,_that.showTrayTitle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Traffic traffic,  bool showTrayTitle)  $default,) {final _that = this;
switch (_that) {
case _TrayTitleState():
return $default(_that.traffic,_that.showTrayTitle);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Traffic traffic,  bool showTrayTitle)?  $default,) {final _that = this;
switch (_that) {
case _TrayTitleState() when $default != null:
return $default(_that.traffic,_that.showTrayTitle);case _:
  return null;

}
}

}

/// @nodoc


class _TrayTitleState implements TrayTitleState {
  const _TrayTitleState({required this.traffic, required this.showTrayTitle});
  

@override final  Traffic traffic;
@override final  bool showTrayTitle;

/// Create a copy of TrayTitleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrayTitleStateCopyWith<_TrayTitleState> get copyWith => __$TrayTitleStateCopyWithImpl<_TrayTitleState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrayTitleState&&(identical(other.traffic, traffic) || other.traffic == traffic)&&(identical(other.showTrayTitle, showTrayTitle) || other.showTrayTitle == showTrayTitle));
}


@override
int get hashCode {
    return Object.hash(runtimeType,traffic,showTrayTitle);
}

@override
String toString() {
    return 'TrayTitleState(traffic: $traffic, showTrayTitle: $showTrayTitle)';
}


}

/// @nodoc
abstract mixin class _$TrayTitleStateCopyWith<$Res> implements $TrayTitleStateCopyWith<$Res> {
  factory _$TrayTitleStateCopyWith(_TrayTitleState value, $Res Function(_TrayTitleState) _then) = __$TrayTitleStateCopyWithImpl;
@override @useResult
$Res call({
 Traffic traffic, bool showTrayTitle
});


@override $TrafficCopyWith<$Res> get traffic;

}
/// @nodoc
class __$TrayTitleStateCopyWithImpl<$Res>
    implements _$TrayTitleStateCopyWith<$Res> {
  __$TrayTitleStateCopyWithImpl(this._self, this._then);

  final _TrayTitleState _self;
  final $Res Function(_TrayTitleState) _then;

/// Create a copy of TrayTitleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? traffic = null,Object? showTrayTitle = null,}) {
  return _then(_TrayTitleState(
traffic: null == traffic ? _self.traffic : traffic // ignore: cast_nullable_to_non_nullable
as Traffic,showTrayTitle: null == showTrayTitle ? _self.showTrayTitle : showTrayTitle // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TrayTitleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrafficCopyWith<$Res> get traffic {
  
  return $TrafficCopyWith<$Res>(_self.traffic, (value) {
    return _then(_self.copyWith(traffic: value));
  });
}
}

/// @nodoc
mixin _$NavigationState {

 PageLabel get pageLabel; List<NavigationItem> get navigationItems; ViewMode get viewMode; String? get locale; int get currentIndex;
/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationStateCopyWith<NavigationState> get copyWith => _$NavigationStateCopyWithImpl<NavigationState>(this as NavigationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NavigationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationState&&(identical(other.pageLabel, _this.pageLabel) || other.pageLabel == _this.pageLabel)&&const DeepCollectionEquality().equals(other.navigationItems, _this.navigationItems)&&(identical(other.viewMode, _this.viewMode) || other.viewMode == _this.viewMode)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.currentIndex, _this.currentIndex) || other.currentIndex == _this.currentIndex));
}


@override
int get hashCode {
  final _this = this as NavigationState;
  return Object.hash(runtimeType,_this.pageLabel,const DeepCollectionEquality().hash(_this.navigationItems),_this.viewMode,_this.locale,_this.currentIndex);
}

@override
String toString() {
  final _this = this as NavigationState;
  return 'NavigationState(pageLabel: ${_this.pageLabel}, navigationItems: ${_this.navigationItems}, viewMode: ${_this.viewMode}, locale: ${_this.locale}, currentIndex: ${_this.currentIndex})';
}


}

/// @nodoc
abstract mixin class $NavigationStateCopyWith<$Res>  {
  factory $NavigationStateCopyWith(NavigationState value, $Res Function(NavigationState) _then) = _$NavigationStateCopyWithImpl;
@useResult
$Res call({
 PageLabel pageLabel, List<NavigationItem> navigationItems, ViewMode viewMode, String? locale, int currentIndex
});




}
/// @nodoc
class _$NavigationStateCopyWithImpl<$Res>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._self, this._then);

  final NavigationState _self;
  final $Res Function(NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageLabel = null,Object? navigationItems = null,Object? viewMode = null,Object? locale = freezed,Object? currentIndex = null,}) {
  return _then(NavigationState(
pageLabel: null == pageLabel ? _self.pageLabel : pageLabel // ignore: cast_nullable_to_non_nullable
as PageLabel,navigationItems: null == navigationItems ? _self.navigationItems : navigationItems // ignore: cast_nullable_to_non_nullable
as List<NavigationItem>,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as ViewMode,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationState].
extension NavigationStatePatterns on NavigationState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationState value)  $default,){
final _that = this;
switch (_that) {
case _NavigationState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PageLabel pageLabel,  List<NavigationItem> navigationItems,  ViewMode viewMode,  String? locale,  int currentIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.pageLabel,_that.navigationItems,_that.viewMode,_that.locale,_that.currentIndex);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PageLabel pageLabel,  List<NavigationItem> navigationItems,  ViewMode viewMode,  String? locale,  int currentIndex)  $default,) {final _that = this;
switch (_that) {
case _NavigationState():
return $default(_that.pageLabel,_that.navigationItems,_that.viewMode,_that.locale,_that.currentIndex);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PageLabel pageLabel,  List<NavigationItem> navigationItems,  ViewMode viewMode,  String? locale,  int currentIndex)?  $default,) {final _that = this;
switch (_that) {
case _NavigationState() when $default != null:
return $default(_that.pageLabel,_that.navigationItems,_that.viewMode,_that.locale,_that.currentIndex);case _:
  return null;

}
}

}

/// @nodoc


class _NavigationState implements NavigationState {
  const _NavigationState({required this.pageLabel, required  List<NavigationItem> navigationItems, required this.viewMode, required this.locale, required this.currentIndex}): _navigationItems = navigationItems;
  

@override final  PageLabel pageLabel;
 final  List<NavigationItem> _navigationItems;
@override List<NavigationItem> get navigationItems {
  if (_navigationItems is EqualUnmodifiableListView) return _navigationItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_navigationItems);
}

@override final  ViewMode viewMode;
@override final  String? locale;
@override final  int currentIndex;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NavigationStateCopyWith<_NavigationState> get copyWith => __$NavigationStateCopyWithImpl<_NavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NavigationState&&(identical(other.pageLabel, pageLabel) || other.pageLabel == pageLabel)&&const DeepCollectionEquality().equals(other.navigationItems, _navigationItems)&&(identical(other.viewMode, viewMode) || other.viewMode == viewMode)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pageLabel,const DeepCollectionEquality().hash(_navigationItems),viewMode,locale,currentIndex);
}

@override
String toString() {
    return 'NavigationState(pageLabel: $pageLabel, navigationItems: $navigationItems, viewMode: $viewMode, locale: $locale, currentIndex: $currentIndex)';
}


}

/// @nodoc
abstract mixin class _$NavigationStateCopyWith<$Res> implements $NavigationStateCopyWith<$Res> {
  factory _$NavigationStateCopyWith(_NavigationState value, $Res Function(_NavigationState) _then) = __$NavigationStateCopyWithImpl;
@override @useResult
$Res call({
 PageLabel pageLabel, List<NavigationItem> navigationItems, ViewMode viewMode, String? locale, int currentIndex
});




}
/// @nodoc
class __$NavigationStateCopyWithImpl<$Res>
    implements _$NavigationStateCopyWith<$Res> {
  __$NavigationStateCopyWithImpl(this._self, this._then);

  final _NavigationState _self;
  final $Res Function(_NavigationState) _then;

/// Create a copy of NavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageLabel = null,Object? navigationItems = null,Object? viewMode = null,Object? locale = freezed,Object? currentIndex = null,}) {
  return _then(_NavigationState(
pageLabel: null == pageLabel ? _self.pageLabel : pageLabel // ignore: cast_nullable_to_non_nullable
as PageLabel,navigationItems: null == navigationItems ? _self._navigationItems : navigationItems // ignore: cast_nullable_to_non_nullable
as List<NavigationItem>,viewMode: null == viewMode ? _self.viewMode : viewMode // ignore: cast_nullable_to_non_nullable
as ViewMode,locale: freezed == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String?,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$GroupsState {

 List<Group> get value;
/// Create a copy of GroupsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupsStateCopyWith<GroupsState> get copyWith => _$GroupsStateCopyWithImpl<GroupsState>(this as GroupsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GroupsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupsState&&const DeepCollectionEquality().equals(other.value, _this.value));
}


@override
int get hashCode {
  final _this = this as GroupsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.value));
}

@override
String toString() {
  final _this = this as GroupsState;
  return 'GroupsState(value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $GroupsStateCopyWith<$Res>  {
  factory $GroupsStateCopyWith(GroupsState value, $Res Function(GroupsState) _then) = _$GroupsStateCopyWithImpl;
@useResult
$Res call({
 List<Group> value
});




}
/// @nodoc
class _$GroupsStateCopyWithImpl<$Res>
    implements $GroupsStateCopyWith<$Res> {
  _$GroupsStateCopyWithImpl(this._self, this._then);

  final GroupsState _self;
  final $Res Function(GroupsState) _then;

/// Create a copy of GroupsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(GroupsState(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupsState].
extension GroupsStatePatterns on GroupsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupsState value)  $default,){
final _that = this;
switch (_that) {
case _GroupsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupsState value)?  $default,){
final _that = this;
switch (_that) {
case _GroupsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Group> value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupsState() when $default != null:
return $default(_that.value);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Group> value)  $default,) {final _that = this;
switch (_that) {
case _GroupsState():
return $default(_that.value);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Group> value)?  $default,) {final _that = this;
switch (_that) {
case _GroupsState() when $default != null:
return $default(_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _GroupsState implements GroupsState {
  const _GroupsState({required  List<Group> value}): _value = value;
  

 final  List<Group> _value;
@override List<Group> get value {
  if (_value is EqualUnmodifiableListView) return _value;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_value);
}


/// Create a copy of GroupsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupsStateCopyWith<_GroupsState> get copyWith => __$GroupsStateCopyWithImpl<_GroupsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupsState&&const DeepCollectionEquality().equals(other.value, _value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_value));
}

@override
String toString() {
    return 'GroupsState(value: $value)';
}


}

/// @nodoc
abstract mixin class _$GroupsStateCopyWith<$Res> implements $GroupsStateCopyWith<$Res> {
  factory _$GroupsStateCopyWith(_GroupsState value, $Res Function(_GroupsState) _then) = __$GroupsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Group> value
});




}
/// @nodoc
class __$GroupsStateCopyWithImpl<$Res>
    implements _$GroupsStateCopyWith<$Res> {
  __$GroupsStateCopyWithImpl(this._self, this._then);

  final _GroupsState _self;
  final $Res Function(_GroupsState) _then;

/// Create a copy of GroupsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_GroupsState(
value: null == value ? _self._value : value // ignore: cast_nullable_to_non_nullable
as List<Group>,
  ));
}


}

/// @nodoc
mixin _$NavigationItemsState {

 List<NavigationItem> get value;
/// Create a copy of NavigationItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NavigationItemsStateCopyWith<NavigationItemsState> get copyWith => _$NavigationItemsStateCopyWithImpl<NavigationItemsState>(this as NavigationItemsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NavigationItemsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NavigationItemsState&&const DeepCollectionEquality().equals(other.value, _this.value));
}


@override
int get hashCode {
  final _this = this as NavigationItemsState;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.value));
}

@override
String toString() {
  final _this = this as NavigationItemsState;
  return 'NavigationItemsState(value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $NavigationItemsStateCopyWith<$Res>  {
  factory $NavigationItemsStateCopyWith(NavigationItemsState value, $Res Function(NavigationItemsState) _then) = _$NavigationItemsStateCopyWithImpl;
@useResult
$Res call({
 List<NavigationItem> value
});




}
/// @nodoc
class _$NavigationItemsStateCopyWithImpl<$Res>
    implements $NavigationItemsStateCopyWith<$Res> {
  _$NavigationItemsStateCopyWithImpl(this._self, this._then);

  final NavigationItemsState _self;
  final $Res Function(NavigationItemsState) _then;

/// Create a copy of NavigationItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? value = null,}) {
  return _then(NavigationItemsState(
value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as List<NavigationItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [NavigationItemsState].
extension NavigationItemsStatePatterns on NavigationItemsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NavigationItemsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NavigationItemsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NavigationItemsState value)  $default,){
final _that = this;
switch (_that) {
case _NavigationItemsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
/// …34027 tokens truncated… injectedRuleProviders,_mitmModules = mitmModules;
  

@override final  String profilesPath;
@override final  int profileId;
 final  Map<String, dynamic> _rawConfig;
@override Map<String, dynamic> get rawConfig {
  if (_rawConfig is EqualUnmodifiableMapView) return _rawConfig;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_rawConfig);
}

@override final  PatchClashConfig realPatchConfig;
@override@JsonKey() final  ProfileOverrides overrides;
@override@JsonKey() final  bool bypassPrivateRoute;
/// Set for a subscription, whose own DNS values an emptied entry replaces.
@override@JsonKey() final  bool keepEmptyDnsOverrides;
@override final  bool appendSystemDns;
 final  List<ProxyGroup> _proxyGroups;
@override List<ProxyGroup> get proxyGroups {
  if (_proxyGroups is EqualUnmodifiableListView) return _proxyGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proxyGroups);
}

 final  List<Rule> _rules;
@override List<Rule> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

 final  List<Rule> _addedRules;
@override List<Rule> get addedRules {
  if (_addedRules is EqualUnmodifiableListView) return _addedRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addedRules);
}

@override final  String defaultUA;
 final  List<String> _authentication;
@override@JsonKey() List<String> get authentication {
  if (_authentication is EqualUnmodifiableListView) return _authentication;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_authentication);
}

 final  Map<String, dynamic> _injectedProxyProviders;
@override@JsonKey() Map<String, dynamic> get injectedProxyProviders {
  if (_injectedProxyProviders is EqualUnmodifiableMapView) return _injectedProxyProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_injectedProxyProviders);
}

 final  Map<String, dynamic> _injectedRuleProviders;
@override@JsonKey() Map<String, dynamic> get injectedRuleProviders {
  if (_injectedRuleProviders is EqualUnmodifiableMapView) return _injectedRuleProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_injectedRuleProviders);
}

@override final  String? matchTarget;
@override@JsonKey() final  bool safeMode;
 final  List<MitmModuleSource> _mitmModules;
@override@JsonKey() List<MitmModuleSource> get mitmModules {
  if (_mitmModules is EqualUnmodifiableListView) return _mitmModules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mitmModules);
}


/// Create a copy of MakeRealProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MakeRealProfileStateCopyWith<_MakeRealProfileState> get copyWith => __$MakeRealProfileStateCopyWithImpl<_MakeRealProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MakeRealProfileState&&(identical(other.profilesPath, profilesPath) || other.profilesPath == profilesPath)&&(identical(other.profileId, profileId) || other.profileId == profileId)&&const DeepCollectionEquality().equals(other.rawConfig, _rawConfig)&&(identical(other.realPatchConfig, realPatchConfig) || other.realPatchConfig == realPatchConfig)&&(identical(other.overrides, overrides) || other.overrides == overrides)&&(identical(other.bypassPrivateRoute, bypassPrivateRoute) || other.bypassPrivateRoute == bypassPrivateRoute)&&(identical(other.keepEmptyDnsOverrides, keepEmptyDnsOverrides) || other.keepEmptyDnsOverrides == keepEmptyDnsOverrides)&&(identical(other.appendSystemDns, appendSystemDns) || other.appendSystemDns == appendSystemDns)&&const DeepCollectionEquality().equals(other.proxyGroups, _proxyGroups)&&const DeepCollectionEquality().equals(other.rules, _rules)&&const DeepCollectionEquality().equals(other.addedRules, _addedRules)&&(identical(other.defaultUA, defaultUA) || other.defaultUA == defaultUA)&&const DeepCollectionEquality().equals(other.authentication, _authentication)&&const DeepCollectionEquality().equals(other.injectedProxyProviders, _injectedProxyProviders)&&const DeepCollectionEquality().equals(other.injectedRuleProviders, _injectedRuleProviders)&&(identical(other.matchTarget, matchTarget) || other.matchTarget == matchTarget)&&(identical(other.safeMode, safeMode) || other.safeMode == safeMode)&&const DeepCollectionEquality().equals(other.mitmModules, _mitmModules));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profilesPath,profileId,const DeepCollectionEquality().hash(_rawConfig),realPatchConfig,overrides,bypassPrivateRoute,keepEmptyDnsOverrides,appendSystemDns,const DeepCollectionEquality().hash(_proxyGroups),const DeepCollectionEquality().hash(_rules),const DeepCollectionEquality().hash(_addedRules),defaultUA,const DeepCollectionEquality().hash(_authentication),const DeepCollectionEquality().hash(_injectedProxyProviders),const DeepCollectionEquality().hash(_injectedRuleProviders),matchTarget,safeMode,const DeepCollectionEquality().hash(_mitmModules));
}

@override
String toString() {
    return 'MakeRealProfileState(profilesPath: $profilesPath, profileId: $profileId, rawConfig: $rawConfig, realPatchConfig: $realPatchConfig, overrides: $overrides, bypassPrivateRoute: $bypassPrivateRoute, keepEmptyDnsOverrides: $keepEmptyDnsOverrides, appendSystemDns: $appendSystemDns, proxyGroups: $proxyGroups, rules: $rules, addedRules: $addedRules, defaultUA: $defaultUA, authentication: $authentication, injectedProxyProviders: $injectedProxyProviders, injectedRuleProviders: $injectedRuleProviders, matchTarget: $matchTarget, safeMode: $safeMode, mitmModules: $mitmModules)';
}


}

/// @nodoc
abstract mixin class _$MakeRealProfileStateCopyWith<$Res> implements $MakeRealProfileStateCopyWith<$Res> {
  factory _$MakeRealProfileStateCopyWith(_MakeRealProfileState value, $Res Function(_MakeRealProfileState) _then) = __$MakeRealProfileStateCopyWithImpl;
@override @useResult
$Res call({
 String profilesPath, int profileId, Map<String, dynamic> rawConfig, PatchClashConfig realPatchConfig, ProfileOverrides overrides, bool bypassPrivateRoute, bool keepEmptyDnsOverrides, bool appendSystemDns, List<ProxyGroup> proxyGroups, List<Rule> rules, List<Rule> addedRules, String defaultUA, List<String> authentication, Map<String, dynamic> injectedProxyProviders, Map<String, dynamic> injectedRuleProviders, String? matchTarget, bool safeMode, List<MitmModuleSource> mitmModules
});


@override $PatchClashConfigCopyWith<$Res> get realPatchConfig;@override $ProfileOverridesCopyWith<$Res> get overrides;

}
/// @nodoc
class __$MakeRealProfileStateCopyWithImpl<$Res>
    implements _$MakeRealProfileStateCopyWith<$Res> {
  __$MakeRealProfileStateCopyWithImpl(this._self, this._then);

  final _MakeRealProfileState _self;
  final $Res Function(_MakeRealProfileState) _then;

/// Create a copy of MakeRealProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profilesPath = null,Object? profileId = null,Object? rawConfig = null,Object? realPatchConfig = null,Object? overrides = null,Object? bypassPrivateRoute = null,Object? keepEmptyDnsOverrides = null,Object? appendSystemDns = null,Object? proxyGroups = null,Object? rules = null,Object? addedRules = null,Object? defaultUA = null,Object? authentication = null,Object? injectedProxyProviders = null,Object? injectedRuleProviders = null,Object? matchTarget = freezed,Object? safeMode = null,Object? mitmModules = null,}) {
  return _then(_MakeRealProfileState(
profilesPath: null == profilesPath ? _self.profilesPath : profilesPath // ignore: cast_nullable_to_non_nullable
as String,profileId: null == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int,rawConfig: null == rawConfig ? _self._rawConfig : rawConfig // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,realPatchConfig: null == realPatchConfig ? _self.realPatchConfig : realPatchConfig // ignore: cast_nullable_to_non_nullable
as PatchClashConfig,overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as ProfileOverrides,bypassPrivateRoute: null == bypassPrivateRoute ? _self.bypassPrivateRoute : bypassPrivateRoute // ignore: cast_nullable_to_non_nullable
as bool,keepEmptyDnsOverrides: null == keepEmptyDnsOverrides ? _self.keepEmptyDnsOverrides : keepEmptyDnsOverrides // ignore: cast_nullable_to_non_nullable
as bool,appendSystemDns: null == appendSystemDns ? _self.appendSystemDns : appendSystemDns // ignore: cast_nullable_to_non_nullable
as bool,proxyGroups: null == proxyGroups ? _self._proxyGroups : proxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<Rule>,addedRules: null == addedRules ? _self._addedRules : addedRules // ignore: cast_nullable_to_non_nullable
as List<Rule>,defaultUA: null == defaultUA ? _self.defaultUA : defaultUA // ignore: cast_nullable_to_non_nullable
as String,authentication: null == authentication ? _self._authentication : authentication // ignore: cast_nullable_to_non_nullable
as List<String>,injectedProxyProviders: null == injectedProxyProviders ? _self._injectedProxyProviders : injectedProxyProviders // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,injectedRuleProviders: null == injectedRuleProviders ? _self._injectedRuleProviders : injectedRuleProviders // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,matchTarget: freezed == matchTarget ? _self.matchTarget : matchTarget // ignore: cast_nullable_to_non_nullable
as String?,safeMode: null == safeMode ? _self.safeMode : safeMode // ignore: cast_nullable_to_non_nullable
as bool,mitmModules: null == mitmModules ? _self._mitmModules : mitmModules // ignore: cast_nullable_to_non_nullable
as List<MitmModuleSource>,
  ));
}

/// Create a copy of MakeRealProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PatchClashConfigCopyWith<$Res> get realPatchConfig {
  
  return $PatchClashConfigCopyWith<$Res>(_self.realPatchConfig, (value) {
    return _then(_self.copyWith(realPatchConfig: value));
  });
}/// Create a copy of MakeRealProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileOverridesCopyWith<$Res> get overrides {
  
  return $ProfileOverridesCopyWith<$Res>(_self.overrides, (value) {
    return _then(_self.copyWith(overrides: value));
  });
}
}

/// @nodoc
mixin _$MitmModuleSource {

 String get content; Map<String, String> get arguments; Map<String, String> get resources;
/// Create a copy of MitmModuleSource
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MitmModuleSourceCopyWith<MitmModuleSource> get copyWith => _$MitmModuleSourceCopyWithImpl<MitmModuleSource>(this as MitmModuleSource, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MitmModuleSource;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MitmModuleSource&&(identical(other.content, _this.content) || other.content == _this.content)&&const DeepCollectionEquality().equals(other.arguments, _this.arguments)&&const DeepCollectionEquality().equals(other.resources, _this.resources));
}


@override
int get hashCode {
  final _this = this as MitmModuleSource;
  return Object.hash(runtimeType,_this.content,const DeepCollectionEquality().hash(_this.arguments),const DeepCollectionEquality().hash(_this.resources));
}

@override
String toString() {
  final _this = this as MitmModuleSource;
  return 'MitmModuleSource(content: ${_this.content}, arguments: ${_this.arguments}, resources: ${_this.resources})';
}


}

/// @nodoc
abstract mixin class $MitmModuleSourceCopyWith<$Res>  {
  factory $MitmModuleSourceCopyWith(MitmModuleSource value, $Res Function(MitmModuleSource) _then) = _$MitmModuleSourceCopyWithImpl;
@useResult
$Res call({
 String content, Map<String, String> arguments, Map<String, String> resources
});




}
/// @nodoc
class _$MitmModuleSourceCopyWithImpl<$Res>
    implements $MitmModuleSourceCopyWith<$Res> {
  _$MitmModuleSourceCopyWithImpl(this._self, this._then);

  final MitmModuleSource _self;
  final $Res Function(MitmModuleSource) _then;

/// Create a copy of MitmModuleSource
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? arguments = null,Object? resources = null,}) {
  return _then(MitmModuleSource(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,arguments: null == arguments ? _self.arguments : arguments // ignore: cast_nullable_to_non_nullable
as Map<String, String>,resources: null == resources ? _self.resources : resources // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [MitmModuleSource].
extension MitmModuleSourcePatterns on MitmModuleSource {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MitmModuleSource value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MitmModuleSource() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MitmModuleSource value)  $default,){
final _that = this;
switch (_that) {
case _MitmModuleSource():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MitmModuleSource value)?  $default,){
final _that = this;
switch (_that) {
case _MitmModuleSource() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String content,  Map<String, String> arguments,  Map<String, String> resources)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MitmModuleSource() when $default != null:
return $default(_that.content,_that.arguments,_that.resources);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String content,  Map<String, String> arguments,  Map<String, String> resources)  $default,) {final _that = this;
switch (_that) {
case _MitmModuleSource():
return $default(_that.content,_that.arguments,_that.resources);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String content,  Map<String, String> arguments,  Map<String, String> resources)?  $default,) {final _that = this;
switch (_that) {
case _MitmModuleSource() when $default != null:
return $default(_that.content,_that.arguments,_that.resources);case _:
  return null;

}
}

}

/// @nodoc


class _MitmModuleSource implements MitmModuleSource {
  const _MitmModuleSource({required this.content,  Map<String, String> arguments = const {},  Map<String, String> resources = const {}}): _arguments = arguments,_resources = resources;
  

@override final  String content;
 final  Map<String, String> _arguments;
@override@JsonKey() Map<String, String> get arguments {
  if (_arguments is EqualUnmodifiableMapView) return _arguments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_arguments);
}

 final  Map<String, String> _resources;
@override@JsonKey() Map<String, String> get resources {
  if (_resources is EqualUnmodifiableMapView) return _resources;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_resources);
}


/// Create a copy of MitmModuleSource
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MitmModuleSourceCopyWith<_MitmModuleSource> get copyWith => __$MitmModuleSourceCopyWithImpl<_MitmModuleSource>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MitmModuleSource&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.arguments, _arguments)&&const DeepCollectionEquality().equals(other.resources, _resources));
}


@override
int get hashCode {
    return Object.hash(runtimeType,content,const DeepCollectionEquality().hash(_arguments),const DeepCollectionEquality().hash(_resources));
}

@override
String toString() {
    return 'MitmModuleSource(content: $content, arguments: $arguments, resources: $resources)';
}


}

/// @nodoc
abstract mixin class _$MitmModuleSourceCopyWith<$Res> implements $MitmModuleSourceCopyWith<$Res> {
  factory _$MitmModuleSourceCopyWith(_MitmModuleSource value, $Res Function(_MitmModuleSource) _then) = __$MitmModuleSourceCopyWithImpl;
@override @useResult
$Res call({
 String content, Map<String, String> arguments, Map<String, String> resources
});




}
/// @nodoc
class __$MitmModuleSourceCopyWithImpl<$Res>
    implements _$MitmModuleSourceCopyWith<$Res> {
  __$MitmModuleSourceCopyWithImpl(this._self, this._then);

  final _MitmModuleSource _self;
  final $Res Function(_MitmModuleSource) _then;

/// Create a copy of MitmModuleSource
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? arguments = null,Object? resources = null,}) {
  return _then(_MitmModuleSource(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,arguments: null == arguments ? _self._arguments : arguments // ignore: cast_nullable_to_non_nullable
as Map<String, String>,resources: null == resources ? _self._resources : resources // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}

/// @nodoc
mixin _$MigrationData {

 Map<String, Object?>? get configMap; List<Rule> get rules; List<Script> get scripts; List<Profile> get profiles; List<DisabledRule> get disabledRules; List<ProxyGroup> get proxyGroups; List<ClashProvider> get clashProviders; List<CustomProxy> get customProxies; List<ProxyDialer> get proxyDialers; List<MitmModule> get mitmModules;
/// Create a copy of MigrationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MigrationDataCopyWith<MigrationData> get copyWith => _$MigrationDataCopyWithImpl<MigrationData>(this as MigrationData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as MigrationData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MigrationData&&const DeepCollectionEquality().equals(other.configMap, _this.configMap)&&const DeepCollectionEquality().equals(other.rules, _this.rules)&&const DeepCollectionEquality().equals(other.scripts, _this.scripts)&&const DeepCollectionEquality().equals(other.profiles, _this.profiles)&&const DeepCollectionEquality().equals(other.disabledRules, _this.disabledRules)&&const DeepCollectionEquality().equals(other.proxyGroups, _this.proxyGroups)&&const DeepCollectionEquality().equals(other.clashProviders, _this.clashProviders)&&const DeepCollectionEquality().equals(other.customProxies, _this.customProxies)&&const DeepCollectionEquality().equals(other.proxyDialers, _this.proxyDialers)&&const DeepCollectionEquality().equals(other.mitmModules, _this.mitmModules));
}


@override
int get hashCode {
  final _this = this as MigrationData;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.configMap),const DeepCollectionEquality().hash(_this.rules),const DeepCollectionEquality().hash(_this.scripts),const DeepCollectionEquality().hash(_this.profiles),const DeepCollectionEquality().hash(_this.disabledRules),const DeepCollectionEquality().hash(_this.proxyGroups),const DeepCollectionEquality().hash(_this.clashProviders),const DeepCollectionEquality().hash(_this.customProxies),const DeepCollectionEquality().hash(_this.proxyDialers),const DeepCollectionEquality().hash(_this.mitmModules));
}

@override
String toString() {
  final _this = this as MigrationData;
  return 'MigrationData(configMap: ${_this.configMap}, rules: ${_this.rules}, scripts: ${_this.scripts}, profiles: ${_this.profiles}, disabledRules: ${_this.disabledRules}, proxyGroups: ${_this.proxyGroups}, clashProviders: ${_this.clashProviders}, customProxies: ${_this.customProxies}, proxyDialers: ${_this.proxyDialers}, mitmModules: ${_this.mitmModules})';
}


}

/// @nodoc
abstract mixin class $MigrationDataCopyWith<$Res>  {
  factory $MigrationDataCopyWith(MigrationData value, $Res Function(MigrationData) _then) = _$MigrationDataCopyWithImpl;
@useResult
$Res call({
 Map<String, Object?>? configMap, List<Rule> rules, List<Script> scripts, List<Profile> profiles, List<DisabledRule> disabledRules, List<ProxyGroup> proxyGroups, List<ClashProvider> clashProviders, List<CustomProxy> customProxies, List<ProxyDialer> proxyDialers, List<MitmModule> mitmModules
});




}
/// @nodoc
class _$MigrationDataCopyWithImpl<$Res>
    implements $MigrationDataCopyWith<$Res> {
  _$MigrationDataCopyWithImpl(this._self, this._then);

  final MigrationData _self;
  final $Res Function(MigrationData) _then;

/// Create a copy of MigrationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? configMap = freezed,Object? rules = null,Object? scripts = null,Object? profiles = null,Object? disabledRules = null,Object? proxyGroups = null,Object? clashProviders = null,Object? customProxies = null,Object? proxyDialers = null,Object? mitmModules = null,}) {
  return _then(MigrationData(
configMap: freezed == configMap ? _self.configMap : configMap // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<Rule>,scripts: null == scripts ? _self.scripts : scripts // ignore: cast_nullable_to_non_nullable
as List<Script>,profiles: null == profiles ? _self.profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<Profile>,disabledRules: null == disabledRules ? _self.disabledRules : disabledRules // ignore: cast_nullable_to_non_nullable
as List<DisabledRule>,proxyGroups: null == proxyGroups ? _self.proxyGroups : proxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,clashProviders: null == clashProviders ? _self.clashProviders : clashProviders // ignore: cast_nullable_to_non_nullable
as List<ClashProvider>,customProxies: null == customProxies ? _self.customProxies : customProxies // ignore: cast_nullable_to_non_nullable
as List<CustomProxy>,proxyDialers: null == proxyDialers ? _self.proxyDialers : proxyDialers // ignore: cast_nullable_to_non_nullable
as List<ProxyDialer>,mitmModules: null == mitmModules ? _self.mitmModules : mitmModules // ignore: cast_nullable_to_non_nullable
as List<MitmModule>,
  ));
}

}


/// Adds pattern-matching-related methods to [MigrationData].
extension MigrationDataPatterns on MigrationData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MigrationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MigrationData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MigrationData value)  $default,){
final _that = this;
switch (_that) {
case _MigrationData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MigrationData value)?  $default,){
final _that = this;
switch (_that) {
case _MigrationData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, Object?>? configMap,  List<Rule> rules,  List<Script> scripts,  List<Profile> profiles,  List<DisabledRule> disabledRules,  List<ProxyGroup> proxyGroups,  List<ClashProvider> clashProviders,  List<CustomProxy> customProxies,  List<ProxyDialer> proxyDialers,  List<MitmModule> mitmModules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MigrationData() when $default != null:
return $default(_that.configMap,_that.rules,_that.scripts,_that.profiles,_that.disabledRules,_that.proxyGroups,_that.clashProviders,_that.customProxies,_that.proxyDialers,_that.mitmModules);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, Object?>? configMap,  List<Rule> rules,  List<Script> scripts,  List<Profile> profiles,  List<DisabledRule> disabledRules,  List<ProxyGroup> proxyGroups,  List<ClashProvider> clashProviders,  List<CustomProxy> customProxies,  List<ProxyDialer> proxyDialers,  List<MitmModule> mitmModules)  $default,) {final _that = this;
switch (_that) {
case _MigrationData():
return $default(_that.configMap,_that.rules,_that.scripts,_that.profiles,_that.disabledRules,_that.proxyGroups,_that.clashProviders,_that.customProxies,_that.proxyDialers,_that.mitmModules);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, Object?>? configMap,  List<Rule> rules,  List<Script> scripts,  List<Profile> profiles,  List<DisabledRule> disabledRules,  List<ProxyGroup> proxyGroups,  List<ClashProvider> clashProviders,  List<CustomProxy> customProxies,  List<ProxyDialer> proxyDialers,  List<MitmModule> mitmModules)?  $default,) {final _that = this;
switch (_that) {
case _MigrationData() when $default != null:
return $default(_that.configMap,_that.rules,_that.scripts,_that.profiles,_that.disabledRules,_that.proxyGroups,_that.clashProviders,_that.customProxies,_that.proxyDialers,_that.mitmModules);case _:
  return null;

}
}

}

/// @nodoc


class _MigrationData implements MigrationData {
  const _MigrationData({ Map<String, Object?>? configMap,  List<Rule> rules = const [],  List<Script> scripts = const [],  List<Profile> profiles = const [],  List<DisabledRule> disabledRules = const [],  List<ProxyGroup> proxyGroups = const [],  List<ClashProvider> clashProviders = const [],  List<CustomProxy> customProxies = const [],  List<ProxyDialer> proxyDialers = const [],  List<MitmModule> mitmModules = const []}): _configMap = configMap,_rules = rules,_scripts = scripts,_profiles = profiles,_disabledRules = disabledRules,_proxyGroups = proxyGroups,_clashProviders = clashProviders,_customProxies = customProxies,_proxyDialers = proxyDialers,_mitmModules = mitmModules;
  

 final  Map<String, Object?>? _configMap;
@override Map<String, Object?>? get configMap {
  final value = _configMap;
  if (value == null) return null;
  if (_configMap is EqualUnmodifiableMapView) return _configMap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Rule> _rules;
@override@JsonKey() List<Rule> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

 final  List<Script> _scripts;
@override@JsonKey() List<Script> get scripts {
  if (_scripts is EqualUnmodifiableListView) return _scripts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scripts);
}

 final  List<Profile> _profiles;
@override@JsonKey() List<Profile> get profiles {
  if (_profiles is EqualUnmodifiableListView) return _profiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_profiles);
}

 final  List<DisabledRule> _disabledRules;
@override@JsonKey() List<DisabledRule> get disabledRules {
  if (_disabledRules is EqualUnmodifiableListView) return _disabledRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_disabledRules);
}

 final  List<ProxyGroup> _proxyGroups;
@override@JsonKey() List<ProxyGroup> get proxyGroups {
  if (_proxyGroups is EqualUnmodifiableListView) return _proxyGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proxyGroups);
}

 final  List<ClashProvider> _clashProviders;
@override@JsonKey() List<ClashProvider> get clashProviders {
  if (_clashProviders is EqualUnmodifiableListView) return _clashProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clashProviders);
}

 final  List<CustomProxy> _customProxies;
@override@JsonKey() List<CustomProxy> get customProxies {
  if (_customProxies is EqualUnmodifiableListView) return _customProxies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customProxies);
}

 final  List<ProxyDialer> _proxyDialers;
@override@JsonKey() List<ProxyDialer> get proxyDialers {
  if (_proxyDialers is EqualUnmodifiableListView) return _proxyDialers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proxyDialers);
}

 final  List<MitmModule> _mitmModules;
@override@JsonKey() List<MitmModule> get mitmModules {
  if (_mitmModules is EqualUnmodifiableListView) return _mitmModules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mitmModules);
}


/// Create a copy of MigrationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MigrationDataCopyWith<_MigrationData> get copyWith => __$MigrationDataCopyWithImpl<_MigrationData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MigrationData&&const DeepCollectionEquality().equals(other.configMap, _configMap)&&const DeepCollectionEquality().equals(other.rules, _rules)&&const DeepCollectionEquality().equals(other.scripts, _scripts)&&const DeepCollectionEquality().equals(other.profiles, _profiles)&&const DeepCollectionEquality().equals(other.disabledRules, _disabledRules)&&const DeepCollectionEquality().equals(other.proxyGroups, _proxyGroups)&&const DeepCollectionEquality().equals(other.clashProviders, _clashProviders)&&const DeepCollectionEquality().equals(other.customProxies, _customProxies)&&const DeepCollectionEquality().equals(other.proxyDialers, _proxyDialers)&&const DeepCollectionEquality().equals(other.mitmModules, _mitmModules));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_configMap),const DeepCollectionEquality().hash(_rules),const DeepCollectionEquality().hash(_scripts),const DeepCollectionEquality().hash(_profiles),const DeepCollectionEquality().hash(_disabledRules),const DeepCollectionEquality().hash(_proxyGroups),const DeepCollectionEquality().hash(_clashProviders),const DeepCollectionEquality().hash(_customProxies),const DeepCollectionEquality().hash(_proxyDialers),const DeepCollectionEquality().hash(_mitmModules));
}

@override
String toString() {
    return 'MigrationData(configMap: $configMap, rules: $rules, scripts: $scripts, profiles: $profiles, disabledRules: $disabledRules, proxyGroups: $proxyGroups, clashProviders: $clashProviders, customProxies: $customProxies, proxyDialers: $proxyDialers, mitmModules: $mitmModules)';
}


}

/// @nodoc
abstract mixin class _$MigrationDataCopyWith<$Res> implements $MigrationDataCopyWith<$Res> {
  factory _$MigrationDataCopyWith(_MigrationData value, $Res Function(_MigrationData) _then) = __$MigrationDataCopyWithImpl;
@override @useResult
$Res call({
 Map<String, Object?>? configMap, List<Rule> rules, List<Script> scripts, List<Profile> profiles, List<DisabledRule> disabledRules, List<ProxyGroup> proxyGroups, List<ClashProvider> clashProviders, List<CustomProxy> customProxies, List<ProxyDialer> proxyDialers, List<MitmModule> mitmModules
});




}
/// @nodoc
class __$MigrationDataCopyWithImpl<$Res>
    implements _$MigrationDataCopyWith<$Res> {
  __$MigrationDataCopyWithImpl(this._self, this._then);

  final _MigrationData _self;
  final $Res Function(_MigrationData) _then;

/// Create a copy of MigrationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? configMap = freezed,Object? rules = null,Object? scripts = null,Object? profiles = null,Object? disabledRules = null,Object? proxyGroups = null,Object? clashProviders = null,Object? customProxies = null,Object? proxyDialers = null,Object? mitmModules = null,}) {
  return _then(_MigrationData(
configMap: freezed == configMap ? _self._configMap : configMap // ignore: cast_nullable_to_non_nullable
as Map<String, Object?>?,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<Rule>,scripts: null == scripts ? _self._scripts : scripts // ignore: cast_nullable_to_non_nullable
as List<Script>,profiles: null == profiles ? _self._profiles : profiles // ignore: cast_nullable_to_non_nullable
as List<Profile>,disabledRules: null == disabledRules ? _self._disabledRules : disabledRules // ignore: cast_nullable_to_non_nullable
as List<DisabledRule>,proxyGroups: null == proxyGroups ? _self._proxyGroups : proxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,clashProviders: null == clashProviders ? _self._clashProviders : clashProviders // ignore: cast_nullable_to_non_nullable
as List<ClashProvider>,customProxies: null == customProxies ? _self._customProxies : customProxies // ignore: cast_nullable_to_non_nullable
as List<CustomProxy>,proxyDialers: null == proxyDialers ? _self._proxyDialers : proxyDialers // ignore: cast_nullable_to_non_nullable
as List<ProxyDialer>,mitmModules: null == mitmModules ? _self._mitmModules : mitmModules // ignore: cast_nullable_to_non_nullable
as List<MitmModule>,
  ));
}


}

/// @nodoc
mixin _$SetupState {

 int? get profileId; int? get profileLastUpdateDate; ProfileType get profileType; ExtendType get extendType; List<Rule> get rules; List<ProxyGroup> get proxyGroups; List<Rule> get addedRules; Script? get script; ProfileOverrides get overrides; List<ClashProvider> get clashProviders; Map<String, int> get profileProviders; List<CustomProxy> get appProxies; Map<int, String> get proxyDialers; String? get matchTarget; List<MitmModuleSource> get mitmModules;
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetupStateCopyWith<SetupState> get copyWith => _$SetupStateCopyWithImpl<SetupState>(this as SetupState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SetupState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetupState&&(identical(other.profileId, _this.profileId) || other.profileId == _this.profileId)&&(identical(other.profileLastUpdateDate, _this.profileLastUpdateDate) || other.profileLastUpdateDate == _this.profileLastUpdateDate)&&(identical(other.profileType, _this.profileType) || other.profileType == _this.profileType)&&(identical(other.extendType, _this.extendType) || other.extendType == _this.extendType)&&const DeepCollectionEquality().equals(other.rules, _this.rules)&&const DeepCollectionEquality().equals(other.proxyGroups, _this.proxyGroups)&&const DeepCollectionEquality().equals(other.addedRules, _this.addedRules)&&(identical(other.script, _this.script) || other.script == _this.script)&&(identical(other.overrides, _this.overrides) || other.overrides == _this.overrides)&&const DeepCollectionEquality().equals(other.clashProviders, _this.clashProviders)&&const DeepCollectionEquality().equals(other.profileProviders, _this.profileProviders)&&const DeepCollectionEquality().equals(other.appProxies, _this.appProxies)&&const DeepCollectionEquality().equals(other.proxyDialers, _this.proxyDialers)&&(identical(other.matchTarget, _this.matchTarget) || other.matchTarget == _this.matchTarget)&&const DeepCollectionEquality().equals(other.mitmModules, _this.mitmModules));
}


@override
int get hashCode {
  final _this = this as SetupState;
  return Object.hash(runtimeType,_this.profileId,_this.profileLastUpdateDate,_this.profileType,_this.extendType,const DeepCollectionEquality().hash(_this.rules),const DeepCollectionEquality().hash(_this.proxyGroups),const DeepCollectionEquality().hash(_this.addedRules),_this.script,_this.overrides,const DeepCollectionEquality().hash(_this.clashProviders),const DeepCollectionEquality().hash(_this.profileProviders),const DeepCollectionEquality().hash(_this.appProxies),const DeepCollectionEquality().hash(_this.proxyDialers),_this.matchTarget,const DeepCollectionEquality().hash(_this.mitmModules));
}

@override
String toString() {
  final _this = this as SetupState;
  return 'SetupState(profileId: ${_this.profileId}, profileLastUpdateDate: ${_this.profileLastUpdateDate}, profileType: ${_this.profileType}, extendType: ${_this.extendType}, rules: ${_this.rules}, proxyGroups: ${_this.proxyGroups}, addedRules: ${_this.addedRules}, script: ${_this.script}, overrides: ${_this.overrides}, clashProviders: ${_this.clashProviders}, profileProviders: ${_this.profileProviders}, appProxies: ${_this.appProxies}, proxyDialers: ${_this.proxyDialers}, matchTarget: ${_this.matchTarget}, mitmModules: ${_this.mitmModules})';
}


}

/// @nodoc
abstract mixin class $SetupStateCopyWith<$Res>  {
  factory $SetupStateCopyWith(SetupState value, $Res Function(SetupState) _then) = _$SetupStateCopyWithImpl;
@useResult
$Res call({
 int? profileId, int? profileLastUpdateDate, ProfileType profileType, ExtendType extendType, List<Rule> rules, List<ProxyGroup> proxyGroups, List<Rule> addedRules, Script? script, ProfileOverrides overrides, List<ClashProvider> clashProviders, Map<String, int> profileProviders, List<CustomProxy> appProxies, Map<int, String> proxyDialers, String? matchTarget, List<MitmModuleSource> mitmModules
});


$ScriptCopyWith<$Res>? get script;$ProfileOverridesCopyWith<$Res> get overrides;

}
/// @nodoc
class _$SetupStateCopyWithImpl<$Res>
    implements $SetupStateCopyWith<$Res> {
  _$SetupStateCopyWithImpl(this._self, this._then);

  final SetupState _self;
  final $Res Function(SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? profileId = freezed,Object? profileLastUpdateDate = freezed,Object? profileType = null,Object? extendType = null,Object? rules = null,Object? proxyGroups = null,Object? addedRules = null,Object? script = freezed,Object? overrides = null,Object? clashProviders = null,Object? profileProviders = null,Object? appProxies = null,Object? proxyDialers = null,Object? matchTarget = freezed,Object? mitmModules = null,}) {
  return _then(SetupState(
profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,profileLastUpdateDate: freezed == profileLastUpdateDate ? _self.profileLastUpdateDate : profileLastUpdateDate // ignore: cast_nullable_to_non_nullable
as int?,profileType: null == profileType ? _self.profileType : profileType // ignore: cast_nullable_to_non_nullable
as ProfileType,extendType: null == extendType ? _self.extendType : extendType // ignore: cast_nullable_to_non_nullable
as ExtendType,rules: null == rules ? _self.rules : rules // ignore: cast_nullable_to_non_nullable
as List<Rule>,proxyGroups: null == proxyGroups ? _self.proxyGroups : proxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,addedRules: null == addedRules ? _self.addedRules : addedRules // ignore: cast_nullable_to_non_nullable
as List<Rule>,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as Script?,overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as ProfileOverrides,clashProviders: null == clashProviders ? _self.clashProviders : clashProviders // ignore: cast_nullable_to_non_nullable
as List<ClashProvider>,profileProviders: null == profileProviders ? _self.profileProviders : profileProviders // ignore: cast_nullable_to_non_nullable
as Map<String, int>,appProxies: null == appProxies ? _self.appProxies : appProxies // ignore: cast_nullable_to_non_nullable
as List<CustomProxy>,proxyDialers: null == proxyDialers ? _self.proxyDialers : proxyDialers // ignore: cast_nullable_to_non_nullable
as Map<int, String>,matchTarget: freezed == matchTarget ? _self.matchTarget : matchTarget // ignore: cast_nullable_to_non_nullable
as String?,mitmModules: null == mitmModules ? _self.mitmModules : mitmModules // ignore: cast_nullable_to_non_nullable
as List<MitmModuleSource>,
  ));
}
/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScriptCopyWith<$Res>? get script {
    if (_self.script == null) {
    return null;
  }

  return $ScriptCopyWith<$Res>(_self.script!, (value) {
    return _then(_self.copyWith(script: value));
  });
}/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileOverridesCopyWith<$Res> get overrides {
  
  return $ProfileOverridesCopyWith<$Res>(_self.overrides, (value) {
    return _then(_self.copyWith(overrides: value));
  });
}
}


/// Adds pattern-matching-related methods to [SetupState].
extension SetupStatePatterns on SetupState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetupState value)  $default,){
final _that = this;
switch (_that) {
case _SetupState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetupState value)?  $default,){
final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? profileId,  int? profileLastUpdateDate,  ProfileType profileType,  ExtendType extendType,  List<Rule> rules,  List<ProxyGroup> proxyGroups,  List<Rule> addedRules,  Script? script,  ProfileOverrides overrides,  List<ClashProvider> clashProviders,  Map<String, int> profileProviders,  List<CustomProxy> appProxies,  Map<int, String> proxyDialers,  String? matchTarget,  List<MitmModuleSource> mitmModules)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.profileId,_that.profileLastUpdateDate,_that.profileType,_that.extendType,_that.rules,_that.proxyGroups,_that.addedRules,_that.script,_that.overrides,_that.clashProviders,_that.profileProviders,_that.appProxies,_that.proxyDialers,_that.matchTarget,_that.mitmModules);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? profileId,  int? profileLastUpdateDate,  ProfileType profileType,  ExtendType extendType,  List<Rule> rules,  List<ProxyGroup> proxyGroups,  List<Rule> addedRules,  Script? script,  ProfileOverrides overrides,  List<ClashProvider> clashProviders,  Map<String, int> profileProviders,  List<CustomProxy> appProxies,  Map<int, String> proxyDialers,  String? matchTarget,  List<MitmModuleSource> mitmModules)  $default,) {final _that = this;
switch (_that) {
case _SetupState():
return $default(_that.profileId,_that.profileLastUpdateDate,_that.profileType,_that.extendType,_that.rules,_that.proxyGroups,_that.addedRules,_that.script,_that.overrides,_that.clashProviders,_that.profileProviders,_that.appProxies,_that.proxyDialers,_that.matchTarget,_that.mitmModules);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? profileId,  int? profileLastUpdateDate,  ProfileType profileType,  ExtendType extendType,  List<Rule> rules,  List<ProxyGroup> proxyGroups,  List<Rule> addedRules,  Script? script,  ProfileOverrides overrides,  List<ClashProvider> clashProviders,  Map<String, int> profileProviders,  List<CustomProxy> appProxies,  Map<int, String> proxyDialers,  String? matchTarget,  List<MitmModuleSource> mitmModules)?  $default,) {final _that = this;
switch (_that) {
case _SetupState() when $default != null:
return $default(_that.profileId,_that.profileLastUpdateDate,_that.profileType,_that.extendType,_that.rules,_that.proxyGroups,_that.addedRules,_that.script,_that.overrides,_that.clashProviders,_that.profileProviders,_that.appProxies,_that.proxyDialers,_that.matchTarget,_that.mitmModules);case _:
  return null;

}
}

}

/// @nodoc


class _SetupState implements SetupState {
  const _SetupState({required this.profileId, required this.profileLastUpdateDate, required this.profileType, required this.extendType, required  List<Rule> rules, required  List<ProxyGroup> proxyGroups, required  List<Rule> addedRules, required this.script, required this.overrides,  List<ClashProvider> clashProviders = const [],  Map<String, int> profileProviders = const {},  List<CustomProxy> appProxies = const [],  Map<int, String> proxyDialers = const {}, this.matchTarget,  List<MitmModuleSource> mitmModules = const []}): _rules = rules,_proxyGroups = proxyGroups,_addedRules = addedRules,_clashProviders = clashProviders,_profileProviders = profileProviders,_appProxies = appProxies,_proxyDialers = proxyDialers,_mitmModules = mitmModules;
  

@override final  int? profileId;
@override final  int? profileLastUpdateDate;
@override final  ProfileType profileType;
@override final  ExtendType extendType;
 final  List<Rule> _rules;
@override List<Rule> get rules {
  if (_rules is EqualUnmodifiableListView) return _rules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rules);
}

 final  List<ProxyGroup> _proxyGroups;
@override List<ProxyGroup> get proxyGroups {
  if (_proxyGroups is EqualUnmodifiableListView) return _proxyGroups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_proxyGroups);
}

 final  List<Rule> _addedRules;
@override List<Rule> get addedRules {
  if (_addedRules is EqualUnmodifiableListView) return _addedRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addedRules);
}

@override final  Script? script;
@override final  ProfileOverrides overrides;
 final  List<ClashProvider> _clashProviders;
@override@JsonKey() List<ClashProvider> get clashProviders {
  if (_clashProviders is EqualUnmodifiableListView) return _clashProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clashProviders);
}

 final  Map<String, int> _profileProviders;
@override@JsonKey() Map<String, int> get profileProviders {
  if (_profileProviders is EqualUnmodifiableMapView) return _profileProviders;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_profileProviders);
}

 final  List<CustomProxy> _appProxies;
@override@JsonKey() List<CustomProxy> get appProxies {
  if (_appProxies is EqualUnmodifiableListView) return _appProxies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appProxies);
}

 final  Map<int, String> _proxyDialers;
@override@JsonKey() Map<int, String> get proxyDialers {
  if (_proxyDialers is EqualUnmodifiableMapView) return _proxyDialers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_proxyDialers);
}

@override final  String? matchTarget;
 final  List<MitmModuleSource> _mitmModules;
@override@JsonKey() List<MitmModuleSource> get mitmModules {
  if (_mitmModules is EqualUnmodifiableListView) return _mitmModules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mitmModules);
}


/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetupStateCopyWith<_SetupState> get copyWith => __$SetupStateCopyWithImpl<_SetupState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetupState&&(identical(other.profileId, profileId) || other.profileId == profileId)&&(identical(other.profileLastUpdateDate, profileLastUpdateDate) || other.profileLastUpdateDate == profileLastUpdateDate)&&(identical(other.profileType, profileType) || other.profileType == profileType)&&(identical(other.extendType, extendType) || other.extendType == extendType)&&const DeepCollectionEquality().equals(other.rules, _rules)&&const DeepCollectionEquality().equals(other.proxyGroups, _proxyGroups)&&const DeepCollectionEquality().equals(other.addedRules, _addedRules)&&(identical(other.script, script) || other.script == script)&&(identical(other.overrides, overrides) || other.overrides == overrides)&&const DeepCollectionEquality().equals(other.clashProviders, _clashProviders)&&const DeepCollectionEquality().equals(other.profileProviders, _profileProviders)&&const DeepCollectionEquality().equals(other.appProxies, _appProxies)&&const DeepCollectionEquality().equals(other.proxyDialers, _proxyDialers)&&(identical(other.matchTarget, matchTarget) || other.matchTarget == matchTarget)&&const DeepCollectionEquality().equals(other.mitmModules, _mitmModules));
}


@override
int get hashCode {
    return Object.hash(runtimeType,profileId,profileLastUpdateDate,profileType,extendType,const DeepCollectionEquality().hash(_rules),const DeepCollectionEquality().hash(_proxyGroups),const DeepCollectionEquality().hash(_addedRules),script,overrides,const DeepCollectionEquality().hash(_clashProviders),const DeepCollectionEquality().hash(_profileProviders),const DeepCollectionEquality().hash(_appProxies),const DeepCollectionEquality().hash(_proxyDialers),matchTarget,const DeepCollectionEquality().hash(_mitmModules));
}

@override
String toString() {
    return 'SetupState(profileId: $profileId, profileLastUpdateDate: $profileLastUpdateDate, profileType: $profileType, extendType: $extendType, rules: $rules, proxyGroups: $proxyGroups, addedRules: $addedRules, script: $script, overrides: $overrides, clashProviders: $clashProviders, profileProviders: $profileProviders, appProxies: $appProxies, proxyDialers: $proxyDialers, matchTarget: $matchTarget, mitmModules: $mitmModules)';
}


}

/// @nodoc
abstract mixin class _$SetupStateCopyWith<$Res> implements $SetupStateCopyWith<$Res> {
  factory _$SetupStateCopyWith(_SetupState value, $Res Function(_SetupState) _then) = __$SetupStateCopyWithImpl;
@override @useResult
$Res call({
 int? profileId, int? profileLastUpdateDate, ProfileType profileType, ExtendType extendType, List<Rule> rules, List<ProxyGroup> proxyGroups, List<Rule> addedRules, Script? script, ProfileOverrides overrides, List<ClashProvider> clashProviders, Map<String, int> profileProviders, List<CustomProxy> appProxies, Map<int, String> proxyDialers, String? matchTarget, List<MitmModuleSource> mitmModules
});


@override $ScriptCopyWith<$Res>? get script;@override $ProfileOverridesCopyWith<$Res> get overrides;

}
/// @nodoc
class __$SetupStateCopyWithImpl<$Res>
    implements _$SetupStateCopyWith<$Res> {
  __$SetupStateCopyWithImpl(this._self, this._then);

  final _SetupState _self;
  final $Res Function(_SetupState) _then;

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? profileId = freezed,Object? profileLastUpdateDate = freezed,Object? profileType = null,Object? extendType = null,Object? rules = null,Object? proxyGroups = null,Object? addedRules = null,Object? script = freezed,Object? overrides = null,Object? clashProviders = null,Object? profileProviders = null,Object? appProxies = null,Object? proxyDialers = null,Object? matchTarget = freezed,Object? mitmModules = null,}) {
  return _then(_SetupState(
profileId: freezed == profileId ? _self.profileId : profileId // ignore: cast_nullable_to_non_nullable
as int?,profileLastUpdateDate: freezed == profileLastUpdateDate ? _self.profileLastUpdateDate : profileLastUpdateDate // ignore: cast_nullable_to_non_nullable
as int?,profileType: null == profileType ? _self.profileType : profileType // ignore: cast_nullable_to_non_nullable
as ProfileType,extendType: null == extendType ? _self.extendType : extendType // ignore: cast_nullable_to_non_nullable
as ExtendType,rules: null == rules ? _self._rules : rules // ignore: cast_nullable_to_non_nullable
as List<Rule>,proxyGroups: null == proxyGroups ? _self._proxyGroups : proxyGroups // ignore: cast_nullable_to_non_nullable
as List<ProxyGroup>,addedRules: null == addedRules ? _self._addedRules : addedRules // ignore: cast_nullable_to_non_nullable
as List<Rule>,script: freezed == script ? _self.script : script // ignore: cast_nullable_to_non_nullable
as Script?,overrides: null == overrides ? _self.overrides : overrides // ignore: cast_nullable_to_non_nullable
as ProfileOverrides,clashProviders: null == clashProviders ? _self._clashProviders : clashProviders // ignore: cast_nullable_to_non_nullable
as List<ClashProvider>,profileProviders: null == profileProviders ? _self._profileProviders : profileProviders // ignore: cast_nullable_to_non_nullable
as Map<String, int>,appProxies: null == appProxies ? _self._appProxies : appProxies // ignore: cast_nullable_to_non_nullable
as List<CustomProxy>,proxyDialers: null == proxyDialers ? _self._proxyDialers : proxyDialers // ignore: cast_nullable_to_non_nullable
as Map<int, String>,matchTarget: freezed == matchTarget ? _self.matchTarget : matchTarget // ignore: cast_nullable_to_non_nullable
as String?,mitmModules: null == mitmModules ? _self._mitmModules : mitmModules // ignore: cast_nullable_to_non_nullable
as List<MitmModuleSource>,
  ));
}

/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ScriptCopyWith<$Res>? get script {
    if (_self.script == null) {
    return null;
  }

  return $ScriptCopyWith<$Res>(_self.script!, (value) {
    return _then(_self.copyWith(script: value));
  });
}/// Create a copy of SetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileOverridesCopyWith<$Res> get overrides {
  
  return $ProfileOverridesCopyWith<$Res>(_self.overrides, (value) {
    return _then(_self.copyWith(overrides: value));
  });
}
}

// dart format on
