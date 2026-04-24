import 'package:flutter/material.dart';
import 'package:jibbab_app/discount_screen.dart'; // 전역 변수 접근을 위해 임포트

class DiscountRegisterScreen extends StatefulWidget {
  const DiscountRegisterScreen({super.key});

  @override
  State<DiscountRegisterScreen> createState() => _DiscountRegisterScreenState();
}

class _DiscountRegisterScreenState extends State<DiscountRegisterScreen> {
  String? _selectedMart;
  final List<String> _marts = ['이마트', '홈플러스', '쿠팡', '편의점', '기타'];

  // 입력값을 가져오기 위한 컨트롤러들
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPriceController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();

  String _discountRate = '';

  @override
  void initState() {
    super.initState();
    _originalPriceController.addListener(_calculateDiscount);
    _discountPriceController.addListener(_calculateDiscount);
  }

  @override
  void dispose() {
    _itemController.dispose();
    _originalPriceController.dispose();
    _discountPriceController.dispose();
    _expiryController.dispose();
    super.dispose();
  }

  // 할인율 자동 계산 로직
  void _calculateDiscount() {
    final double original = double.tryParse(_originalPriceController.text.replaceAll(',', '')) ?? 0;
    final double discount = double.tryParse(_discountPriceController.text.replaceAll(',', '')) ?? 0;

    if (original > 0 && discount > 0 && original > discount) {
      final rate = ((original - discount) / original * 100).round();
      setState(() => _discountRate = '$rate% 할인');
    } else {
      setState(() => _discountRate = '');
    }
  }

  // 🌟 등록하기 버튼 눌렀을 때 실행되는 핵심 로직
  void _submitForm() {
    // 1. 필수 입력값 검증 (빈 칸 체크)
    if (_selectedMart == null ||
        _itemController.text.trim().isEmpty ||
        _originalPriceController.text.trim().isEmpty ||
        _discountPriceController.text.trim().isEmpty ||
        _expiryController.text.trim().isEmpty) {

      // 에러 스낵바 띄우기
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('필수 항목을 모두 입력해주세요! 🚨'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return; // 검증 실패 시 여기서 멈춤
    }

    // 2. 마트에 따른 뱃지 색상 지정
    Color martColor = Colors.grey;
    if (_selectedMart == '이마트') martColor = Colors.blue;
    if (_selectedMart == '홈플러스') martColor = Colors.red;
    if (_selectedMart == '쿠팡') martColor = Colors.cyan;
    if (_selectedMart == '편의점') martColor = Colors.deepPurple;

    // 3. 전역 리스트의 맨 앞(index 0)에 새 데이터 삽입
    globalDiscounts.insert(0, {
      'mart': _selectedMart,
      'item': _itemController.text.trim(),
      'discount': _discountRate.isNotEmpty ? _discountRate : '할인율 없음',
      'originalPrice': '${_originalPriceController.text}원',
      'salePrice': '${_discountPriceController.text}원',
      'expiry': _expiryController.text.trim(),
      'author': 'seona', // 내 프로필 이름
      'time': '방금 전',
      'likes': 0,
      'color': martColor,
    });

    // 4. 이전 화면으로 돌아가기 (true 값을 넘겨서 성공했음을 알림)
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.black), onPressed: () => Navigator.pop(context)),
        title: const Text('할인정보 등록', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소', style: TextStyle(color: Colors.black54))),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20), color: const Color(0xFFEAF3DE),
              child: const Text('주변의 할인 정보를 공유해주세요! 🛒', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('마트 / 플랫폼 선택 *'),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    hint: const Text('선택해주세요'),
                    value: _selectedMart,
                    items: _marts.map((mart) => DropdownMenuItem(value: mart, child: Text(mart))).toList(),
                    onChanged: (val) => setState(() => _selectedMart = val),
                  ),
                  const SizedBox(height: 24),

                  _buildLabel('품목명 *'),
                  TextField(controller: _itemController, decoration: _inputDecoration().copyWith(hintText: '예) 신선 특란 30구')),
                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _buildLabel('원래 가격 *'),
                        TextField(controller: _originalPriceController, keyboardType: TextInputType.number, decoration: _inputDecoration().copyWith(suffixText: '원')),
                      ])),
                      const SizedBox(width: 16),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        _buildLabel('할인 가격 *'),
                        TextField(controller: _discountPriceController, keyboardType: TextInputType.number, decoration: _inputDecoration().copyWith(suffixText: '원')),
                      ])),
                    ],
                  ),
                  if (_discountRate.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [Text(_discountRate, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18))]),
                    ),
                  const SizedBox(height: 24),

                  _buildLabel('유효기간 *'),
                  TextField(controller: _expiryController, decoration: _inputDecoration().copyWith(hintText: '예) 4월 30일까지', suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey, size: 20))),
                  const SizedBox(height: 24),

                  _buildLabel('추가 메모 (선택사항)'),
                  TextField(maxLines: 4, decoration: _inputDecoration().copyWith(hintText: '위치나 팁 등 추가 정보를 적어주세요.')),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: ElevatedButton(
            onPressed: _submitForm, // 👈 검증 및 등록 로직 실행
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            child: const Text('등록하기', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 8.0), child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.bold)));

  InputDecoration _inputDecoration() => InputDecoration(
    filled: true, fillColor: Colors.grey.shade50, contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)),
    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF1D9E75), width: 2)),
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
  );
}