import 'package:flutter/material.dart';

class DiscountRegisterScreen extends StatefulWidget {
  const DiscountRegisterScreen({super.key});

  @override
  State<DiscountRegisterScreen> createState() => _DiscountRegisterScreenState();
}

class _DiscountRegisterScreenState extends State<DiscountRegisterScreen> {
  String? _selectedMart;
  final List<String> _marts = ['이마트', '홈플러스', '쿠팡', '편의점', '기타'];

  final TextEditingController _originalPriceController = TextEditingController();
  final TextEditingController _discountPriceController = TextEditingController();
  String _discountRate = '';

  @override
  void initState() {
    super.initState();
    // 가격이 입력될 때마다 할인율 자동 계산
    _originalPriceController.addListener(_calculateDiscount);
    _discountPriceController.addListener(_calculateDiscount);
  }

  @override
  void dispose() {
    _originalPriceController.dispose();
    _discountPriceController.dispose();
    super.dispose();
  }

  void _calculateDiscount() {
    final originalText = _originalPriceController.text.replaceAll(',', '');
    final discountText = _discountPriceController.text.replaceAll(',', '');

    final double original = double.tryParse(originalText) ?? 0;
    final double discount = double.tryParse(discountText) ?? 0;

    if (original > 0 && discount > 0 && original > discount) {
      final rate = ((original - discount) / original * 100).round();
      setState(() {
        _discountRate = '$rate% 할인';
      });
    } else {
      setState(() {
        _discountRate = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1D9E75);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '할인정보 등록',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소', style: TextStyle(color: Colors.black54)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 2. 안내 문구 배너
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              color: const Color(0xFFEAF3DE),
              child: Row(
                children: const [
                  Text(
                    '주변의 할인 정보를 공유해주세요! 🛒',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // 3. 입력 폼 영역
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel('마트 / 플랫폼 선택'),
                  DropdownButtonFormField<String>(
                    decoration: _inputDecoration(),
                    hint: const Text('선택해주세요'),
                    value: _selectedMart,
                    items: _marts.map((String mart) {
                      return DropdownMenuItem(value: mart, child: Text(mart));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedMart = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 24),

                  _buildLabel('품목명'),
                  TextField(
                    decoration: _inputDecoration().copyWith(hintText: '예) 신선 특란 30구'),
                  ),
                  const SizedBox(height: 24),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('원래 가격'),
                            TextField(
                              controller: _originalPriceController,
                              keyboardType: TextInputType.number,
                              decoration: _inputDecoration().copyWith(suffixText: '원'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('할인 가격'),
                            TextField(
                              controller: _discountPriceController,
                              keyboardType: TextInputType.number,
                              decoration: _inputDecoration().copyWith(suffixText: '원'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 할인율 자동 표시 영역
                  if (_discountRate.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _discountRate,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 24),

                  _buildLabel('유효기간'),
                  TextField(
                    decoration: _inputDecoration().copyWith(
                      hintText: '예) 4월 30일까지 / 재고 소진 시',
                      suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                    ),
                  ),
                  const SizedBox(height: 24),

                  _buildLabel('추가 메모 (선택사항)'),
                  TextField(
                    maxLines: 4,
                    decoration: _inputDecoration().copyWith(
                      hintText: '위치나 팁 등 추가 정보를 적어주세요.',
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      // 4. 하단 고정 버튼
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('할인정보가 성공적으로 등록되었습니다!')),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Text(
              '등록하기',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // 라벨 위젯 (회색 작은 글씨)
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 공통 입력창 디자인 (포커스 시 초록색 테두리)
  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey.shade50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF1D9E75), width: 2), // 포커스 시 초록색
      ),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
    );
  }
}