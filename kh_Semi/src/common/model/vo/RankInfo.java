package common.model.vo;

public class RankInfo {
	private int rank;
	private String memberId;
	private String nickname;
	private int count;
	
	public RankInfo() {
	}

	public RankInfo(int rank, String memberId, String nickname, int count) {
		this.rank = rank;
		this.memberId = memberId;
		this.nickname = nickname;
		this.count = count;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	@Override
	public String toString() {
		return "RankInfo [rank=" + rank + ", memberId=" + memberId + ", nickname=" + nickname + ", count=" + count
				+ "]";
	}

	
	
	
}
