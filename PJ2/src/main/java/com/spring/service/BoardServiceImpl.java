package com.spring.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.domain.BoardVO;
import com.spring.domain.Criteria;
import com.spring.domain.SerarchCriteria;
import com.spring.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	private BoardDAO dao;

	//추가1
	//게시물 등록 : (1)tbl_board, (2) tbl_attach           ==>트랜잭션
	@Transactional
	@Override
	public void regist(BoardVO vo) throws Exception {
		dao.create(vo);
		String[] files = vo.getFiles();
		if(files == null) {
			return;
		}
		for(String fileName : files)
			dao.addAttach(fileName);
	}
	
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bno) throws Exception {
		dao.updateViewCnt(bno);
		return dao.read(bno);
	}
//추가2
	@Transactional
	@Override
	public void modify(BoardVO vo) throws Exception {
		dao.update(vo);
		
		Integer bno = vo.getBno();
		dao.deleteAttach(bno);
		String[] files = vo.getFiles();
		if(files == null) {
			return;
		}
		for(String fileName : files)
			dao.replaceAttach(fileName, bno);

	}
//추가3
	@Transactional
	@Override
	public void remove(Integer bno) throws Exception {
		dao.deleteAttach(bno);
		dao.delete(bno);
	}

	@Override
	public List<BoardVO> listAll() throws Exception {
	
		return dao.listAll();
	}

	@Override
	public List<BoardVO> listCriteria(Criteria cri) throws Exception {
		
		return dao.listCriteria(cri);
	}

	@Override
	public int listCountCriteria(Criteria cri) throws Exception {
		return dao.countPaging(cri);
		
	}

	@Override
	public List<BoardVO> listSearchCriteria(SerarchCriteria cri) throws Exception {
		
		return dao.listSearch(cri);
	}

	@Override
	public int listSearchCount(SerarchCriteria cri) throws Exception {
		
		return dao.listSearchCount(cri);
	}

	//첨부파일
	@Override
	public List<String> getAttach(Integer bno) throws Exception {
		
		return dao.getAttach(bno);
	}

}
