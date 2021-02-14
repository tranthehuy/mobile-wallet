enum MainMenuActions { 
  none,
  update,
  summarize,
  config,
  help
}

typedef FormSubmitCallback = void Function(dynamic data);

Map<String, String> translatedText = {
  'Sổ chi tiêu': 'Vietnamese Wallet',
  'Thêm giao dịch mới': 'Create new transaction',
  'Cập nhật sổ': 'Update wallet',
  'Thống kê': 'Summarize',
  'Thiết lập ứng dụng': 'Application Settings',
  'Hỗ trợ': 'Support',
  'Liên hệ: tranthehuythesecond@gmail.com': 'Contact: tranthehuythesecond@gmail.com'
};