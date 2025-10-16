package model;

import java.sql.Date;

public class DocGia {
    private int maDocGia;
    private String hoTen;
    private Date ngaySinh;
    private String diaChi;
    private String dienThoai;
    private String email;
    private Integer maTK; // Nullable - có thể null nếu chưa liên kết tài khoản
    private Date ngayCapThe;
    private Date ngayHetHanThe;

    // Constructor mặc định
    public DocGia() {}

    // Constructor đầy đủ
    public DocGia(int maDocGia, String hoTen, Date ngaySinh, String diaChi, 
                  String dienThoai, String email, Integer maTK, 
                  Date ngayCapThe, Date ngayHetHanThe) {
        this.maDocGia = maDocGia;
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.diaChi = diaChi;
        this.dienThoai = dienThoai;
        this.email = email;
        this.maTK = maTK;
        this.ngayCapThe = ngayCapThe;
        this.ngayHetHanThe = ngayHetHanThe;
    }

    // Constructor không có maDocGia (dùng khi tạo mới)
    public DocGia(String hoTen, Date ngaySinh, String diaChi, 
                  String dienThoai, String email, Integer maTK, 
                  Date ngayCapThe, Date ngayHetHanThe) {
        this.hoTen = hoTen;
        this.ngaySinh = ngaySinh;
        this.diaChi = diaChi;
        this.dienThoai = dienThoai;
        this.email = email;
        this.maTK = maTK;
        this.ngayCapThe = ngayCapThe;
        this.ngayHetHanThe = ngayHetHanThe;
    }

    // Getters và Setters
    public int getMaDocGia() {
        return maDocGia;
    }

    public void setMaDocGia(int maDocGia) {
        this.maDocGia = maDocGia;
    }

    public String getHoTen() {
        return hoTen;
    }

    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
    }

    public Date getNgaySinh() {
        return ngaySinh;
    }

    public void setNgaySinh(Date ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    public String getDiaChi() {
        return diaChi;
    }

    public void setDiaChi(String diaChi) {
        this.diaChi = diaChi;
    }

    public String getDienThoai() {
        return dienThoai;
    }

    public void setDienThoai(String dienThoai) {
        this.dienThoai = dienThoai;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getMaTK() {
        return maTK;
    }

    public void setMaTK(Integer maTK) {
        this.maTK = maTK;
    }

    public Date getNgayCapThe() {
        return ngayCapThe;
    }

    public void setNgayCapThe(Date ngayCapThe) {
        this.ngayCapThe = ngayCapThe;
    }

    public Date getNgayHetHanThe() {
        return ngayHetHanThe;
    }

    public void setNgayHetHanThe(Date ngayHetHanThe) {
        this.ngayHetHanThe = ngayHetHanThe;
    }

    @Override
    public String toString() {
        return "DocGia{" +
                "maDocGia=" + maDocGia +
                ", hoTen='" + hoTen + '\'' +
                ", ngaySinh=" + ngaySinh +
                ", diaChi='" + diaChi + '\'' +
                ", dienThoai='" + dienThoai + '\'' +
                ", email='" + email + '\'' +
                ", maTK=" + maTK +
                ", ngayCapThe=" + ngayCapThe +
                ", ngayHetHanThe=" + ngayHetHanThe +
                '}';
    }
}
