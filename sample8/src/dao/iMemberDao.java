package dao;

import dto.MemberDto;

public interface iMemberDao {

	public boolean addMember(MemberDto dto);
	
	public boolean getId(String id);
	
	public MemberDto login(MemberDto dto);
}
