// This class manages all API endpoints used throughout the app.
// 
// Benefits:
// - Centralized endpoint management
// - No need to repeat base URLs everywhere
// - Easy maintenance and updates
//
// Instead of:
// http.get(Uri.parse('https://api.example.com/test1/123'));
// http.post(Uri.parse('https://api.example.com/test2'));
//
// Simply use:
// http.get(Uri.parse('$baseUrl${AppApiEndpoint.test1('123')}'));
// http.post(Uri.parse('$baseUrl${AppApiEndpoint.test2}'));

class AppApiEndpoint {
  const AppApiEndpoint._();
  
  //static const String baseUrl = 'https://healthy-amazed-hog.ngrok-free.app';
  
  // Static endpoints - no parameters required
  // static const String officeToPdf = "/v1/office_to_pdf";
  // static const String mergePdf = "/v1/merge";
  // static const String splitPdf = "/v1/split";
  // static const String deletePages = "/v1/delete_pages";
  // static const String lockPdf = "/v1/lock";
  // static const String unlockPdf = "/v1/unlock";
  // static const String watermark = "/v1/watermark";
  // static const String pageNumber = "/v1/pagenumber";
  // static const String compress = "/v1/compress";
  // static const String rotate = "/v1/rotate";
  // static const String ocr = "/v1/ocr";
  // static const String scanImages = "/v1/scan-images";
  // static const String pdfToJpg = "/v1/pdf_to_jpg";
  // static const String requestNewFeature = "/v1/request-new-feature";
  
  // Example: Dynamic endpoints with parameters
  // static String getUserById(String id) => '/users/$id';
  
  // Example: Endpoints with validation
  // static String getUserById(int userId) {
  //   assert(userId > 0, 'User ID must be positive');
  //   return '/users/$userId';
  // }
}