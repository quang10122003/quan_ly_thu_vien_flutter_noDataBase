// class lưu trữ sách trong thư viện 
class Book {
  int id;
  String name_book;
  int so_luong;
  int so_luong_da_muon; 
  bool co_the_muon; 
   int soLuongConLai(){
    return (so_luong - so_luong_da_muon);
  }
  Book({
    required this.id,
    required this.name_book,
    required this.so_luong,
    this.so_luong_da_muon = 0,
    this.co_the_muon = true,
  });
}
