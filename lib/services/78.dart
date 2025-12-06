import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymeeService {

  static Future<String> createPayment(int amount, String description, String orderId) async {

    const apiKey = "YOUR-PAYMEE-API-KEY"; // 🔥 à remplacer
    const baseUrl = "https://sandbox.paymee.tn/api/v2/payments/create";

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": apiKey,
      },
      body: jsonEncode({
        "amount": amount,
        "note": description,
        "orderId": orderId,
        "return_url": "https://learntounsi.com/return",  // TON URL
        "cancel_url": "https://learntounsi.com/cancel",
      }),
    );

    final data = jsonDecode(response.body);

    if (data["status"] != 200) {
      throw Exception(data["message"]);
    }

    return data["data"]["payment_url"]; // 🔥 lien de paiement Paymee
  }
}
