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
  'Thống kê thu nhập': 'Summarize profit',
  'Lọc': 'Filter',
  'Thiết lập ứng dụng': 'Application Settings',
  'Hỗ trợ': 'Support',
  'Liên hệ: tranthehuythesecond@gmail.com': 'Contact: tranthehuythesecond@gmail.com',
  'Đã cập nhật cài đặt mới': 'Updated new config',
  'Đã xoá': 'Removed',
  'Xoá hết các giao dịch': 'Remove all transaction',
  'Đơn vị nhập': 'Unit',
  'Đồng': 'Dong',
  'Ngàn Đồng': 'Thousand Dong',
  'Ngôn ngữ': 'Language',
  'Tiếng Việt': 'Vietnamese',
  'Tiếng Anh': 'English',
  'Lưu': 'Save',
  'Huỷ': 'Cancel',
  'Chi phí: #1 đồng': 'Outcome: #1 Dong',
  'Thu nhập: #1 đồng': 'Income: #1 Dong',
  'Tổng: #1 đồng': 'Sum: #1 Dong',
  'đồng': 'Dong',
  'Ngày tạo: #1': 'Created At: #1'
};