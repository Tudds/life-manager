# Hướng Dẫn Deploy Lên Vercel

Vì chúng ta đã tách file `config.js` để bảo mật, bạn cần làm theo các bước sau để deploy ứng dụng lên Vercel mà vẫn bảo vệ được API keys.

## Bước 1: Chuẩn bị trên GitHub
1. Commit và push code hiện tại lên GitHub repository của bạn.
   - Lưu ý: File `config.js` sẽ **không** được push lên (do `.gitignore`), chỉ có `config.example.js`.

## Bước 2: Import vào Vercel
1. Truy cập [Vercel Dashboard](https://vercel.com/dashboard).
2. Click **"Add New..."** -> **"Project"**.
3. Import repository GitHub của bạn.

## Bước 3: Cấu hình Build & Environment Variables (QUAN TRỌNG)

Trong trang cấu hình project ("Configure Project"):

### 1. Build Command
Tại phần **Build and Output Settings**:
- **Build Command**: Nhập dòng lệnh sau:
  ```bash
  bash build.sh
  ```
  *(Script này sẽ tự động tạo file config.js từ các biến môi trường)*
- **Output Directory**: Để trống (hoặc `.` nếu bắt buộc).

### 2. Environment Variables
Tại phần **Environment Variables**, thêm 3 biến sau (lấy giá trị từ file `config.js` trên máy bạn):

| Name | Value |
|------|-------|
| `CLIENT_ID` | Copy từ `config.js` (ví dụ: `6350...com`) |
| `API_KEY` | Copy từ `config.js` (ví dụ: `AIza...`) |
| `SPREADSHEET_ID` | Copy từ `config.js` (ví dụ: `1WFa...`) |

*Lưu ý: Không thêm dấu ngoặc kép/đơn bao quanh giá trị.*

4. Click **Deploy**.

## Bước 4: Cấu hình Google Cloud Console (BẮT BUỘC)
Sau khi deploy thành công, Vercel sẽ cấp cho bạn một domain (ví dụ: `https://life-manager-xyz.vercel.app`). Bạn cần khai báo domain này với Google.

1. Truy cập [Google Cloud Console](https://console.cloud.google.com/apis/credentials).
2. Chọn Project của bạn -> Vào mục **Credentials**.
3. Chọn **OAuth 2.0 Client ID** mà bạn đang dùng.
4. Tại mục **Authorized JavaScript origins**:
   - Thêm URL của Vercel (ví dụ: `https://your-project.vercel.app`).
   - **Lưu ý**: Không có dấu `/` ở cuối.
5. Click **Save**.

## Kiểm Tra
- Truy cập trang web trên Vercel.
- Thử đăng nhập bằng Google.
- Nếu gặp lỗi `redirect_uri_mismatch` hoặc "Origin not allowed", hãy chờ vài phút để Google cập nhật thay đổi ở Bước 4 hoặc xóa cache trình duyệt.
