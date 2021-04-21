package board.model.vo;

import java.sql.Timestamp;

public class Board {
   private int boardNum;
   private int boardLevel;
   private String boardTitle;
   private String boardContent;
   private String boardWriter;
   private String pImage;
   private String nickName;
   private String rankName;
   private int boardCount;
   private Timestamp createDate;
   private Timestamp modifyDate;
   private String status;
   
   public Board() {
   }
   

   public Board(String boardTitle, String boardContent, String boardWriter) {
      this.boardTitle = boardTitle;
      this.boardContent = boardContent;
      this.boardWriter = boardWriter;
   }
   
   public Board(int boardNum, String boardTitle, String boardContent, String boardWriter) {
      this.boardNum = boardNum;
      this.boardTitle = boardTitle;
      this.boardContent = boardContent;
      this.boardWriter = boardWriter;
   }


   public Board(int boardNum, String boardWriter, String nickName, String boardTitle, int boardCount, Timestamp createDate,
         Timestamp modifyDate) {
      this.boardNum = boardNum;
      this.boardWriter = boardWriter;
      this.nickName = nickName;
      this.boardTitle = boardTitle;
      this.boardCount = boardCount;
      this.createDate = createDate;
      this.modifyDate = modifyDate;
   }


   public Board(int boardNum, int boardLevel, String boardTitle, String boardContent, String boardWriter, String nickName,
         String rankName, int boardCount, Timestamp createDate, Timestamp modifyDate, String pImage) {
      this.boardNum = boardNum;
      this.boardLevel = boardLevel;
      this.boardTitle = boardTitle;
      this.boardContent = boardContent;
      this.boardWriter = boardWriter;
      this.nickName = nickName;
      this.rankName = rankName;
      this.boardCount = boardCount;
      this.createDate = createDate;
      this.modifyDate = modifyDate;
      this.pImage = pImage;
   }


   public Board(int boardNum, String boardTitle, String boardContent, String boardWriter, String nickName,
         int boardCount, Timestamp createDate, Timestamp modifyDate, String status) {
      this.boardNum = boardNum;
      this.boardTitle = boardTitle;
      this.boardContent = boardContent;
      this.boardWriter = boardWriter;
      this.nickName = nickName;
      this.boardCount = boardCount;
      this.createDate = createDate;
      this.modifyDate = modifyDate;
      this.status = status;
   }
   
   


   public Board(int boardNum, String boardTitle, String nickName, int boardCount, Timestamp createDate) {
      super();
      this.boardNum = boardNum;
      this.boardTitle = boardTitle;
      this.nickName = nickName;
      this.boardCount = boardCount;
      this.createDate = createDate;
   }


   public int getBoardNum() {
      return boardNum;
   }


   public void setBoardNum(int boardNum) {
      this.boardNum = boardNum;
   }


   public int getBoardLevel() {
      return boardLevel;
   }


   public void setBoardLevel(int boardLevel) {
      this.boardLevel = boardLevel;
   }


   public String getBoardTitle() {
      return boardTitle;
   }


   public void setBoardTitle(String boardTitle) {
      this.boardTitle = boardTitle;
   }


   public String getBoardContent() {
      return boardContent;
   }


   public void setBoardContent(String boardContent) {
      this.boardContent = boardContent;
   }


   public String getBoardWriter() {
      return boardWriter;
   }


   public void setBoardWriter(String boardWriter) {
      this.boardWriter = boardWriter;
   }


   public String getpImage() {
      return pImage;
   }


   public void setpImage(String pImage) {
      this.pImage = pImage;
   }


   public String getNickName() {
      return nickName;
   }


   public void setNickName(String nickName) {
      this.nickName = nickName;
   }


   public String getRankName() {
      return rankName;
   }


   public void setRankName(String rankName) {
      this.rankName = rankName;
   }


   public int getBoardCount() {
      return boardCount;
   }


   public void setBoardCount(int boardCount) {
      this.boardCount = boardCount;
   }


   public Timestamp getCreateDate() {
      return createDate;
   }


   public void setCreateDate(Timestamp createDate) {
      this.createDate = createDate;
   }


   public Timestamp getModifyDate() {
      return modifyDate;
   }


   public void setModifyDate(Timestamp modifyDate) {
      this.modifyDate = modifyDate;
   }


   public String getStatus() {
      return status;
   }


   public void setStatus(String status) {
      this.status = status;
   }


   @Override
   public String toString() {
      return "Board [boardNum=" + boardNum + ", boardLevel=" + boardLevel + ", boardTitle=" + boardTitle
            + ", boardContent=" + boardContent + ", boardWriter=" + boardWriter + ", pImage=" + pImage
            + ", nickName=" + nickName + ", rankName=" + rankName + ", boardCount=" + boardCount + ", createDate="
            + createDate + ", modifyDate=" + modifyDate + ", status=" + status + "]";
   }


   
}