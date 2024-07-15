class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.56.1:3001/api/v1/";
  // static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // static const String baseUrl =
  //     "https://0b8e-2400-1a00-b030-86b5-1cd3-81fc-88e6-a726.ngrok-free.app/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllStudent = "auth/getAllStudents";
  static const String getStudentsByBatch = "auth/getStudentsByBatch/";
  static const String getStudentsByCourse = "auth/getStudentsByCourse/";
  static const String updateStudent = "auth/updateStudent/";
  static const String deleteStudent = "auth/deleteStudent/";
  static const String getUser = "auth/getUser";
  static const String uploadImage = "auth/uploadImage";
  static const String imageUrl = "http://192.168.56.1:3001/uploads/";
  // static const String imageUrl =
  //     "https://0b8e-2400-1a00-b030-86b5-1cd3-81fc-88e6-a726.ngrok-free.app/products/";

  // ====================== Batch Routes ======================
  static const String createBatch = "batch/createBatch";
  static const String getAllBatch = "batch/getAllBatches";

  // ====================== Course Routes ======================
  static const String createCourse = "course/createCourse";
  static const String getAllCourse = "course/getAllCourse";

  //product
  static const String createProduct = "product/createProduct";
  static const String getAllProducts = "product/getAllProducts";
  static const String uploadProductImage = "product/uploadImage";
  static const String getProduct = "product/";
  static const String deleteProduct = "product/";
  static const String editProduct = "product/";

  //order
  static const String createCart = "order/createOrder";

  static const String getAllCart = "order/getAllOrder";

  static const String getCart = "order/user";

  static const String deleteCart = "order/";
}
