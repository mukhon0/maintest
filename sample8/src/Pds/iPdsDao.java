package Pds;

import java.util.List;

public interface iPdsDao {

	public List<PdsDto> getPdsList();
	
	public boolean writePds(PdsDto pds);
	
	public PdsDto detailPds(int seq);
	
	public void readCount(int seq);
	
	public void downCount(int seq);
}
