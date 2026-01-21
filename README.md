# Life Manager - Hướng dẫn Cài đặt và Sử dụng

## Tổng quan

Life Manager là ứng dụng quản lý cuộc sống cá nhân toàn diện, bao gồm:
- 💰 Quản lý tài chính cá nhân
- 🎯 Theo dõi mục tiêu
- ✅ Quản lý thói quen hằng ngày
- 📊 Báo cáo và phân tích

**Backend**: Google Sheets (miễn phí, an toàn, dễ quản lý)

## Bước 1: Tạo Google Cloud Project

### 1.1 Truy cập Google Cloud Console
1. Đi tới [Google Cloud Console](https://console.cloud.google.com/)
2. Đăng nhập bằng tài khoản Google của bạn
3. Nhấp vào dropdown "Select a project" ở thanh top bar
4. Chọn "NEW PROJECT"

### 1.2 Tạo Project mới
1. **Project name**: `LifeManager`
2. **Location**: Để mặc định hoặc chọn organization (nếu có)
3. Nhấp **CREATE**
4. Đợi vài giây để project được tạo

### 1.3 Enable Google Sheets API
1. Trong project mới tạo, vào menu bên trái
2. Chọ **APIs & Services** > **Enable APIs and Services**
3. Tìm kiếm "Google Sheets API"
4. Chọn **Google Sheets API** từ kết quả
5. Nhấp **ENABLE**

## Bước 2: Tạo OAuth 2.0 Credentials

### 2.1 Configure OAuth Consent Screen
1. Vào **APIs & Services** > **OAuth consent screen**
2. Chọn **External** (cho personal use)
3. Nhấp **CREATE**
4. Điền thông tin:
   - **App name**: `Life Manager`
   - **User support email**: Email của bạn
   - **Developer contact information**: Email của bạn
5. Nhấp **SAVE AND CONTINUE**
6. **Scopes**: Nhấp **SAVE AND CONTINUE** (bỏ qua)
7. **Test users**: Thêm email của bạn
8. Nhấp **SAVE AND CONTINUE**

### 2.2 Create OAuth Client ID
1. Vào **APIs & Services** > **Credentials**
2. Nhấp **+ CREATE CREDENTIALS** > **OAuth client ID**
3. **Application type**: **Web application**
4. **Name**: `Life Manager Web Client`
5. **Authorized JavaScript origins**:
   - Nhấp **+ ADD URI**
   - Thêm: `http://localhost:8000` (hoặc domain của bạn)
   - Nếu deploy lên web, thêm domain thực tế (vd: `https://yourdomain.com`)
6. **Authorized redirect URIs**: Có thể để trống với client-side app
7. Nhấp **CREATE**
8. **LƯU LẠI**:
   - `Client ID`: Bắt đầu với `xxxxx.apps.googleusercontent.com`
   - Bạn sẽ cần điền vào file HTML

### 2.3 Create API Key
1. Vẫn ở **Credentials**, nhấp **+ CREATE CREDENTIALS** > **API key**
2. Sao chép API key được tạo
3. (Optional) Nhấp **RESTRICT KEY** để giới hạn:
   - **API restrictions** > chọn **Restrict key**
   - Chọn **Google Sheets API**
   - **SAVE**

## Bước 3: Tạo Google Spreadsheet

### 3.1 Tạo Spreadsheet mới
1. Đi tới [Google Sheets](https://sheets.google.com/)
2. Nhấp **Blank** để tạo spreadsheet mới
3. Đặt tên: `Life Manager Database`

### 3.2 Tạo các Sheets
Tạo 5 sheets sau (nhấp dấu **+** ở dưới cùng):

#### Sheet 1: **Transactions**
Header Row (Row 1):
```
ID | Date | Category | Description | Type | Amount | Wallet | Status
```

Ví dụ dữ liệu (Row 2):
```
1 | 2024-01-21 | Ăn uống | Cà phê sáng | Expense | 35000 | Tiền mặt | Completed
```

#### Sheet 2: **Goals**
Header Row (Row 1):
```
ID | Title | Description | Progress | Deadline | Status | Category | Milestones
```

Ví dụ dữ liệu (Row 2):
```
1 | Học Tiếng Anh | IELTS 7.0 | 50 | 2024-12-31 | Active | Education | 15/30 bài
```

#### Sheet 3: **Habits**
Header Row (Row 1):
```
ID | Title | Description | Category | Schedule | Streak | CompletionRate | Icon
```

Ví dụ dữ liệu (Row 2):
```
1 | Chạy bộ sáng | 5km mỗi ngày | Health | 05:30 | 12 | 85 | directions_run
```

#### Sheet 4: **HabitLogs**
Header Row (Row 1):
```
ID | HabitID | Date | Completed | Notes
```

Ví dụ dữ liệu (Row 2):
```
1 | 1 | 2024-01-21 | TRUE | Chạy được 5.2km
```

#### Sheet 5: **Categories**
Header Row (Row 1):
```
ID | Name | Type | Icon | Color
```

Ví dụ dữ liệu:
```
1 | Ăn uống | Transaction | restaurant | #13ec5b
2 | Di chuyển | Transaction | directions_car | #3b82f6
3 | Mua sắm | Transaction | shopping_bag | #f59e0b
```

### 3.3 Lấy Spreadsheet ID
1. Mở spreadsheet vừa tạo
2. Nhìn vào URL thanh địa chỉ:
   ```
   https://docs.google.com/spreadsheets/d/SPREADSHEET_ID_HERE/edit
   ```
3. Sao chép phần `SPREADSHEET_ID_HERE`
4. Ví dụ: `1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms`

### 3.4 Chia sẻ Spreadsheet
1. Nhấp nút **Share** ở góc trên phải
2. Thêm email của bạn (nếu chưa có)
3. Đặt quyền **Editor**
4. Nhấp **Done**

## Bước 4: Cấu hình Application

### 4.1 Mở file life-manager.html
Mở file `life-manager.html` bằng text editor (VS Code, Notepad++, etc.)

### 4.2 Tìm phần CONFIG (khoảng dòng 720)
```javascript
const CONFIG = {
    CLIENT_ID: 'YOUR_GOOGLE_CLIENT_ID.apps.googleusercontent.com',
    API_KEY: 'YOUR_API_KEY',
    SPREADSHEET_ID: 'YOUR_SPREADSHEET_ID',
    SCOPES: 'https://www.googleapis.com/auth/spreadsheets',
    DISCOVERY_DOCS: ['https://sheets.googleapis.com/$discovery/rest?version=v4']
};
```

### 4.3 Thay thế giá trị
- `CLIENT_ID`: Paste OAuth Client ID từ Bước 2.2
- `API_KEY`: Paste API Key từ Bước 2.3
- `SPREADSHEET_ID`: Paste Spreadsheet ID từ Bước 3.3

Ví dụ:
```javascript
const CONFIG = {
    CLIENT_ID: '123456789-abc.apps.googleusercontent.com',
    API_KEY: 'AIzaSyABC123XYZ789',
    SPREADSHEET_ID: '1BxiMVs0XRA5nFMdKvBdBZjgmUUqptlbs74OgvE2upms',
    SCOPES: 'https://www.googleapis.com/auth/spreadsheets',
    DISCOVERY_DOCS: ['https://sheets.googleapis.com/$discovery/rest?version=v4']
};
```

### 4.4 Lưu file

## Bước 5: Chạy Application

### ⚠️ QUAN TRỌNG
Google OAuth **không hoạt động** khi mở file HTML trực tiếp (`file:///...`).
Bạn **BẮT BUỘC** phải chạy qua HTTP server.

### Cách 1: Python HTTP Server (Khuyến nghị)
Nếu bạn có Python:

```bash
cd /home/dtu/Downloads/stitch_b_ng_i_u_khi_n_th_i_quen_h_ng_ng_y
python3 -m http.server 8000
```

Sau đó mở trình duyệt và truy cập: `http://localhost:8000/life-manager.html`

### Cách 2: Node.js HTTP Server
Nếu bạn có Node.js:

```bash
npx http-server -p 8000
```

### Cách 3: VS Code Live Server
1. Cài đặt extension "Live Server" trong VS Code
2. Click chuột phải vào `life-manager.html`
3. Chọn "Open with Live Server"

### Cách 4: Deploy lên Netlify/Vercel (Production)
1. Tạo tài khoản trên [Netlify](https://netlify.com) hoặc [Vercel](https://vercel.com)
2. Drag & drop folder vào dashboard
3. Nhận được URL production (vd: `https://your-app.netlify.app`)
4. **Quan trọng**: Quay lại Google Cloud Console > Credentials
5. Thêm production URL vào **Authorized JavaScript origins**

## Bước 6: Đăng nhập và Sử dụng

### 6.1 Lần đầu đăng nhập
1. Truy cập `http://localhost:8000/life-manager.html`
2. Nhấp **Đăng nhập với Google**
3. Chọn tài khoản Google
4. Cho phép app truy cập Google Sheets của bạn
5. Được redirect về app

### 6.2 Sử dụng các tính năng

#### 💰 Quản lý Chi tiêu
- Xem tổng quan thu chi
- Thêm giao dịch mới
- Xem biểu đồ phân bổ chi tiêu

#### 🎯 Mục tiêu Cá nhân
- Tạo mục tiêu mới
- Theo dõi tiến độ
- Xem deadline sắp tới

#### ✅ Thói quen Hằng ngày
- Thêm thói quen mới
- Check-in hàng ngày
- Xem streak và completion rate

## Khắc phục Sự cố

### Lỗi: "Access blocked: This app has not been verified"
**Giải pháp**: Nhấp "Advanced" > "Go to Life Manager (unsafe)"
- Đây là bình thường vì app chưa được Google verify
- App chỉ truy cập dữ liệu của bạn, hoàn toàn an toàn

### Lỗi: "Error loading library"
**Nguyên nhân**: Mở file trực tiếp thay vì qua HTTP server
**Giải pháp**: Chạy HTTP server như hướng dẫn Bước 5

### Lỗi: "The request is missing a valid API key"
**Nguyên nhân**: API_KEY không đúng hoặc thiếu
**Giải pháp**: Kiểm tra lại CONFIG trong file HTML

### Lỗi: "The caller does not have permission"
**Nguyên nhân**: 
- Google Sheets API chưa được enable
- Spreadsheet chưa được share với tài khoản đang đăng nhập
**Giải pháp**: Kiểm tra lại Bước 1.3 và Bước 3.4

### Dữ liệu không hiển thị
**Nguyên nhân**: Sheet tên hoặc cấu trúc không đúng
**Giải pháp**: 
1. Mở Console (F12)
2. Xem lỗi trong tab Console
3. Kiểm tra lại tên sheets: `Transactions`, `Goals`, `Habits`, `HabitLogs`, `Categories`
4. Kiểm tra header row (Row 1) có đúng không

## Cấu trúc Dữ liệu

### Transactions Sheet
- **ID**: Unique identifier
- **Date**: Ngày giao dịch (YYYY-MM-DD)
- **Category**: Danh mục (Ăn uống, Di chuyển, etc.)
- **Description**: Mô tả chi tiết
- **Type**: `Income` hoặc `Expense`
- **Amount**: Số tiền (số nguyên, không có dấu phân cách)
- **Wallet**: Ví nguồn (Tiền mặt, Ngân hàng, etc.)
- **Status**: `Completed`, `Pending`, `Overdue`

### Goals Sheet
- **ID**: Unique identifier
- **Title**: Tên mục tiêu
- **Description**: Mô tả chi tiết
- **Progress**: Tiến độ (0-100)
- **Deadline**: Hạn chót (YYYY-MM-DD)
- **Status**: `Active`, `Completed`, `Paused`
- **Category**: Danh mục
- **Milestones**: Các mốc quan trọng

### Habits Sheet
- **ID**: Unique identifier
- **Title**: Tên thói quen
- **Description**: Mô tả
- **Category**: Danh mục (Health, Education, etc.)
- **Schedule**: Lịch trình (05:30, Cả ngày, etc.)
- **Streak**: Chuỗi ngày liên tục
- **CompletionRate**: Tỷ lệ hoàn thành (0-100)
- **Icon**: Material icon name

### HabitLogs Sheet
- **ID**: Unique identifier (timestamp)
- **HabitID**: ID của habit trong Habits sheet
- **Date**: Ngày thực hiện (YYYY-MM-DD)
- **Completed**: `TRUE` hoặc `FALSE`
- **Notes**: Ghi chú

## Tính năng Nâng cao

### Backup Dữ liệu
Dữ liệu được lưu trên Google Sheets nên tự động được backup bởi Google.
Bạn cũng có thể:
1. File > Download > Excel (.xlsx)
2. Hoặc sử dụng Google Takeout

### Đồng bộ Multi-device
Chỉ cần đăng nhập cùng tài khoản Google trên các thiết bị khác nhau.

### Chia sẻ với Người thân
1. Mở Google Spreadsheet
2. Share với email của người thân
3. Họ sẽ thấy cùng dữ liệu khi đăng nhập app

## Bảo mật

- ✅ Dữ liệu lưu trên Google Sheets của bạn
- ✅ Không có server backend của bên thứ 3
- ✅ OAuth 2.0 authentication
- ✅ Chỉ bạn (và người bạn share) mới truy cập được

## Hỗ trợ

Gặp vấn đề? 
1. Kiểm tra lại từng bước trong hướng dẫn
2. Mở Console (F12) để xem lỗi cụ thể
3. Kiểm tra Google Sheets có đúng cấu trúc không

## License

MIT License - Free to use and modify
