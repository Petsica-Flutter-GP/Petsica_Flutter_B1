abstract class UpdateCartState {}

/// ✅ الحالة الأولية
class UpdateCartInitial extends UpdateCartState {}

/// ✅ حالة التحديث الناجح
class UpdateCartSuccess extends UpdateCartState {}

/// ✅ حالة التحديث الفاشل
class UpdateCartFailure extends UpdateCartState {
  final String errorMessage;
  UpdateCartFailure(this.errorMessage);
}

/// ✅ حالة تحميل تحديث السلة
class UpdateCartLoading extends UpdateCartState {}
