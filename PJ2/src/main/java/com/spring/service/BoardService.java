package com.spring.service;

import java.util.List;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SerarchCriteria;

public interface BoardService {
	public void regist(BoardVO vo) throws Exception;//insert
	public BoardVO read(Integer bno) throws Exception;//select
	public void modify(BoardVO vo) throws Exception; //update
	public void remove(Integer bno) throws Exception;//delete
	public List<BoardVO> listAll() throws Exception; //select

    //----------------------------------------Paging
	public List<BoardVO> listCriteria(Criteria cri) throws Exception;
	public int listCountCriteria(Criteria cri) throws Exception;
	
	//Search
	public List<BoardVO> listSearchCriteria(SerarchCriteria cri) throws Exception;
	public int listSearchCount(SerarchCriteria cri) throws Exception;
	
	//첨부파일
	public List<String> getAttach(Integer bno) throws Exception;
}
