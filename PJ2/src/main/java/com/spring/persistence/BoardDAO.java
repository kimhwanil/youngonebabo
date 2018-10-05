package com.spring.persistence;
import java.util.List;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SerarchCriteria;
public interface BoardDAO {
	public void create(BoardVO vo) throws Exception;//insert
	public BoardVO read(Integer bno)throws Exception;//select
	public void update(BoardVO vo) throws Exception;
	public void delete(Integer bno) throws Exception;
	public List<BoardVO> listAll() throws Exception; //select
	
	//Paging
	public List<BoardVO> listPage(int page) throws Exception;
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	
	//totalCount를 반환할수 있게 처리
	public int countPaging(Criteria cri ) throws Exception;
	
	//Search
	public List<BoardVO> listSearch(SerarchCriteria cri) throws Exception;//searchType, keyword를 통해서 탐색
	public int listSearchCount(SerarchCriteria cri) throws Exception;//탐색한 글의 갯수

	//댓글(reply) 카운트 수
	public void updateReplyCnt(Integer bno, int amount) throws Exception;
	//글(bno) 조회수
	public void updateViewCnt(Integer bno) throws Exception;
	
	//첨부파일
	public void addAttach(String fullName) throws Exception;
	public List<String> getAttach(Integer bno) throws Exception;
	public void deleteAttach(Integer bno) throws Exception;
	public void replaceAttach(String fullName,Integer bno) throws Exception;
	
	
	
	
	
	
}
