package group.model.vo;

import java.sql.Date;

public class Group {
   private int groupNum;
   private String groupTitle;
   private int groupCount;
   private String explain;
   private String groupWriter;
   private String memberId;
   private int price;
   private Date gDate;
   private Date startDate;
   private Date endDate;
   private String status;
   private String nickName;
   
   public Group() {}


   public Group(int groupNum, String groupTitle, int groupCount, String explain, String memberId, String nickName ,Date gDate, Date startDate,
         Date endDate) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.groupCount = groupCount;
      this.explain = explain;
      this.nickName = nickName;
      this.memberId = memberId;
      this.gDate = gDate;
      this.startDate = startDate;
      this.endDate = endDate;
   }
   
   public Group(String groupTitle, String explain, String memberId, int price, Date startDate, Date endDate) {
      super();
      this.groupTitle = groupTitle;
      this.explain = explain;
      this.memberId = memberId;
      this.price = price;
      this.startDate = startDate;
      this.endDate = endDate;
   }

   public Group(int groupNum, String groupTitle, String explain, String memberId, int price, 
           Date gDate, Date startDate, Date endDate, String status) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.explain = explain;
      this.memberId = memberId;
      this.price = price;
      this.gDate = gDate;
      this.startDate = startDate;
      this.endDate = endDate;
      this.status = status;
   }
   
   

   public Group(int groupNum, String groupTitle, int groupCount, String memberId, Date startDate,Date endDate, Date gDate, String nickName) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.groupCount = groupCount;
      this.memberId = memberId;
      this.startDate = startDate;
      this.endDate = endDate;
      this.gDate = gDate;
      this.nickName = nickName;
   }



   public Group(int groupNum, String groupTitle, int groupCount, String explain, int price, Date gDate, Date startDate,
         Date endDate, String nickName, String groupWriter) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.groupCount = groupCount;
      this.explain = explain;
      this.price = price;
      this.gDate = gDate;
      this.startDate = startDate;
      this.endDate = endDate;
      this.nickName = nickName;
      this.groupWriter = groupWriter;
   }

   

   public Group(int groupNum, String groupTitle, String explain, String memberId) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.explain = explain;
      this.memberId = memberId;
   }
   
   
   

   public Group(int groupNum, String groupTitle, String explain, String memberId, int price, Date startDate,
         Date endDate) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.explain = explain;
      this.memberId = memberId;
      this.price = price;
      this.startDate = startDate;
      this.endDate = endDate;
   }


   public Group(String groupTitle,  String explain, int groupNum, String groupWriter) {
      super();
      this.groupTitle = groupTitle;
      this.groupNum = groupNum;
      this.explain = explain;
      this.groupWriter = groupWriter;
   }

   

   public Group(int groupNum, String groupTitle, int price) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.price = price;
   }
   
   


   


   public Group(int groupNum, String groupTitle, int groupCount, Date gDate, String nickName) {
      super();
      this.groupNum = groupNum;
      this.groupTitle = groupTitle;
      this.groupCount = groupCount;
      this.gDate = gDate;
      this.nickName = nickName;
   }


   public int getGroupNum() {
      return groupNum;
   }

   public void setGroupNum(int groupNum) {
      this.groupNum = groupNum;
   }

   public String getGroupTitle() {
      return groupTitle;
   }

   public void setGroupTitle(String groupTitle) {
      this.groupTitle = groupTitle;
   }

   public String getExplain() {
      return explain;
   }

   public void setExplain(String explain) {
      this.explain = explain;
   }

   public String getMemberId() {
      return memberId;
   }

   public void setMemberId(String memberId) {
      this.memberId = memberId;
   }

   public int getPrice() {
      return price;
   }

   public void setPrice(int price) {
      this.price = price;
   }


   public Date getgDate() {
      return gDate;
   }

   public void setgDate(Date gDate) {
      this.gDate = gDate;
   }

   public Date getStartDate() {
      return startDate;
   }

   public void setStartDate(Date startDate) {
      this.startDate = startDate;
   }

   public Date getEndDate() {
      return endDate;
   }

   public void setEndDate(Date endDate) {
      this.endDate = endDate;
   }

   public String getStatus() {
      return status;
   }

   public void setStatus(String status) {
      this.status = status;
   }

   

   public String getNickName() {
      return nickName;
   }



   public void setNickName(String nickName) {
      this.nickName = nickName;
   }
   
   

   public int getGroupCount() {
      return groupCount;
   }


   public void setGroupCount(int groupCount) {
      this.groupCount = groupCount;
   }


   public String getGroupWriter() {
      return groupWriter;
   }


   public void setGroupWriter(String groupWriter) {
      this.groupWriter = groupWriter;
   }


   @Override
   public String toString() {
      return "Group [groupNum=" + groupNum + ", groupTitle=" + groupTitle + ", groupCount=" + groupCount
            + ", explain=" + explain + ", groupWriter=" + groupWriter + ", memberId=" + memberId + ", price="
            + price + ", gDate=" + gDate + ", startDate=" + startDate + ", endDate=" + endDate + ", status="
            + status + ", nickName=" + nickName + "]";
   }


   
   
}