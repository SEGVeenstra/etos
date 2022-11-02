extension ObjectExt on Object {
  T? tryCast<T>() {
    if (this is T) return this as T;
    return null;
  }
}
