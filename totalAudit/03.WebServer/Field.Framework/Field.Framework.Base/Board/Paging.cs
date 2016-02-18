// 게시판 Paging
using System;
using System.Data;

public class Paging {
	private short mPageNo;		// 페이지 번호
	private int mBlockSize;		// 블럭 내 페이지 수
	private byte mPageSize;		// 페이지 크기 (페이지 내 게시물 수)
	private int mRecordCnt;		// 전체 혹은 블럭 내 게시물 수
	private sbyte mIsNext;		// 블럭 이동 클릭 (이전블럭:-1, 페이지내 이동:0, 다음블럭:1)
	private sbyte mJumpSize;	// 점프한 페이지 수
	private int mCheckBlock;	// 다음블럭이 있는지 계산하기 위한 값
	private int mCheckNext;		// 다음블럭에 데이터가 있는지 알기위해 필요한 값 (sp 파라미터)
	private long mFirstNo;		// 페이지 내 처음 값 기준1
	private long mFirstVo;		// 페이지 내 처음 값 기준2
	private long mLimitNo;		// 페이지 내 마지막 값 기준1
	private long mLimitVo;		// 페이지 내 마지막 값 기준2
	private long mDefaultNo;	// 기본 초기 값1
	private long mDefaultVo;	// 기본 초기 값2

	public Paging() {
		mPageNo		= 1;
		mBlockSize	= 10;
		mPageSize	= 15;
		mRecordCnt	= 0;
		mIsNext		= 0;
		mJumpSize	= 0;
		mCheckBlock	= 0;
		mCheckNext	= 0;
		mFirstNo	= 0;
		mFirstVo	= 0;
		mLimitNo	= 0;
		mLimitVo	= 0;
		mDefaultNo	= 9223372036854775000;
		mDefaultVo	= 9223372036854775000;
	}


	#region initialize
	public short pPageNo {
		get { return mPageNo; }
		set { mPageNo = value; }
	}

	public byte pPageSize {
		get { return mPageSize; }
		set { mPageSize = value; }
	}

	public int pBlockSize {
		get { return mBlockSize; }
		set { mBlockSize = value; }
	}

	public int pRecordCnt {
		get { return mRecordCnt; }
		set { mRecordCnt = value; }
	}

	public sbyte pIsNext {
		get { return mIsNext; }
		set { mIsNext = value; }
	}

	public sbyte pJumpSize {
		get { return mJumpSize; }
		set { mJumpSize = value; }
	}

	public int pCheckBlock {
		get { return mCheckBlock; }
		set { mCheckBlock = value; }
	}

	public int pCheckNext {
		get { return mCheckNext; }
		set { mCheckNext = value; }
	}

	public long pDefaultNo {
		get { return mDefaultNo; }
		set { mDefaultNo = value; }
	}

	public long pDefaultVo {
		get { return mDefaultVo; }
		set { mDefaultVo = value; }
	}

	public long pFirstNo {
		get { return mFirstNo; }
		set { mFirstNo = value; }
	}

	public long pFirstVo {
		get { return mFirstVo; }
		set { mFirstVo = value; }
	}

	public long pLimitNo {
		get { return mLimitNo; }
		set { mLimitNo = value; }
	}

	public long pLimitVo {
		get { return mLimitVo; }
		set { mLimitVo = value; }
	}
	#endregion initialize


	// 변수 초기화
	public void fnSetParam() {
		// 페이지 번호
		if ( pPageNo == 0 ) {
			pPageNo = 1;
		}
		// 점프 크기 체크
		if ( pJumpSize == 0 ) {
			pJumpSize = 1;
		} else if ( pJumpSize > pBlockSize ) {
			pJumpSize = (sbyte) pBlockSize;
		} else if ( pJumpSize < -(pPageSize) ) {
			pJumpSize = (sbyte) -(pPageSize);
		}
		// 다음블럭 계산에 필요한 값
		if ( pPageNo > 1 && pIsNext == 0 ) {
			pCheckNext = 0;
		} else if ( pIsNext == 1 && pJumpSize > 0 && pBlockSize != pJumpSize ) {
			pCheckNext = (2 * (pPageSize * pBlockSize)) - ((pBlockSize - (pJumpSize - 1)) * pPageSize) + 1;
		} else if ( pIsNext == 1 ) {
			pCheckNext = (2 * (pPageSize * pBlockSize)) + 1;
		}
	}


	#region Article list
	// 게시판 페이징 string 만들기
	public string fnPaging(int pNextBlock) {
		string oPaging = "";
		const string vTmpPage = "<a href=\"javascript:fnMovePage({0},{1},{2},{3},{4},{5});\">{6}</a>\n";
		const string vFirstPage = "<a href=\"javascript:;\" class=\"on\">{0}</a>\n";

		if ( pNextBlock > 0 ) {
			mRecordCnt = pNextBlock;
		}
		if ( mRecordCnt == 0 ) {
			mRecordCnt = 1;
		}

		if ( mIsNext == -1 ) {
			// 이전 블럭으로 이동
			mRecordCnt = (mCheckBlock * (mPageSize * mBlockSize)) + 1;
		} else if ( mIsNext == 1 && mJumpSize > 0 && mBlockSize != mJumpSize ) {
			// 블럭 중간 페이지에서 점프 한 블럭 계산 보정
			mRecordCnt -= (mPageSize * mBlockSize) - ((mBlockSize - (mJumpSize-1)) * mPageSize);
		} else if ( mIsNext == 1 ) { //&& _RecordCnt > ((_PageSize*_BlockSize) + 1) ) {
			// 블럭 첫 페이지에서 점프 한 경우 블럭 계산 보정
			mRecordCnt -= mPageSize * (mBlockSize-1);
		}

		// 블럭내 페이지 이동에 대한 보정
		if ( mIsNext == 0 && mJumpSize > 0 && mPageNo > 1 ) {
			// 블럭 내에서 11 -> 12 순으로 이동
			mRecordCnt -= mJumpSize * mPageSize;
		} else if ( mIsNext == 0 && mJumpSize < 0 && mPageNo > 1 ) {
			// 블럭 내에서 12 -> 11 순으로 이동
			mRecordCnt += Math.Abs(mJumpSize) * mPageSize;
		}


		int vPageNo, vJumpSize;
	//	int vBlockNo = ((pPageNo-1) / pBlockSize) + 1;
		int vStartNo = (mBlockSize * ((mPageNo-1) / mBlockSize)) + 1;
		int vLoopCnt = (mBlockSize * ((mPageNo-1) / mBlockSize)) + mBlockSize;

		// 마지막 블럭에서 페이지 번호 초과 (위에서 무조건 pBlockSize만큼 잡고 시작함)
		if ( vLoopCnt > (mPageNo + (mRecordCnt / mPageSize)) ) {
			vLoopCnt = (int) ((mPageNo-1) + Math.Ceiling(Convert.ToDecimal(mRecordCnt) / mPageSize));
		}

		// fnMovePage(pPageNo, pRowCnt, pLastNo, pLastVo, pJumpSize, pIsNext)
		// 이전 블럭
		if ( mPageNo > mBlockSize && mPageNo >= vStartNo ) {
			vPageNo		= vStartNo - 1;				// 시작 페이지 번호(21) - 1 = 20
			vJumpSize	= vStartNo - mPageNo - 1;	// 시작 페이지 번호(21) - 현재 이동한 페이지 번호(23) - 1 = -3
			oPaging		+= string.Format(vTmpPage, 1, mRecordCnt, mDefaultNo, mDefaultVo, 1, 0, "1");
			oPaging		+= string.Format(vTmpPage, vPageNo, mRecordCnt, mFirstNo, mFirstVo, vJumpSize, -1, "<<");
		}

		for ( int i = vStartNo; i <= vLoopCnt; ++i ) {
			vPageNo = i;
			vJumpSize = i - mPageNo;

			// 현재 페이지
			if ( mPageNo == i ) {
				oPaging += string.Format(vFirstPage, i);
			}
			// 최초 블럭에서 1페이지
			else if ( i == 1 ) {
				oPaging += string.Format(vTmpPage, 1, mRecordCnt, mDefaultNo, mDefaultVo, 1, 0, 1);
			}
			// 현재 이전 페이지
			else if ( mPageNo > i ) {
				oPaging += string.Format(vTmpPage, vPageNo, mRecordCnt, mFirstNo, mFirstVo, vJumpSize, 0, vPageNo);
			}
			// 현재 이후 페이지
			else {
				oPaging += string.Format(vTmpPage, vPageNo, mRecordCnt, mLimitNo, mLimitVo, vJumpSize, 0, vPageNo);
			}
		}

		// 다음 블럭
		if ( (mPageSize * mBlockSize) < ((Math.Abs(vStartNo - mPageNo) * mPageSize) + mRecordCnt) ) {
			vPageNo		= vStartNo + mBlockSize;			// 시작 페이지 번호(21) + 블럭 크기(10) = 31
			vJumpSize	= vStartNo - mPageNo + mBlockSize;	// 시작 페이지 번호(21) - 현재 이동한 페이지 번호(23) + 블럭 크기(10) = 8
			oPaging		+= string.Format(vTmpPage, vPageNo, mRecordCnt, mLimitNo, mLimitVo, vJumpSize, 1, ">>");
		}
	//	oPaging += "</ul>";

		return oPaging;
	}
	#endregion Article list


	#region Reply list
	// 덧글 페이징 ajax 이용 DataTable
	public DataTable fnPagingReply(int pNextBlock) {
		if ( pNextBlock > 0 ) {
			mRecordCnt = pNextBlock;
		}
		if ( mRecordCnt == 0 ) {
			mRecordCnt = 1;
		}

		if ( mIsNext == -1 ) {
			// 이전 블럭으로 이동
			mRecordCnt = (mCheckBlock * (mPageSize * mBlockSize)) + 1;
		} else if ( mIsNext == 1 && mJumpSize > 0 && mBlockSize != mJumpSize ) {
			// 블럭 중간 페이지에서 점프 한 블럭 계산 보정
			mRecordCnt -= (mPageSize * mBlockSize) - ((mBlockSize - (mJumpSize - 1)) * mPageSize);
		} else if ( mIsNext == 1 ) { //&& _RecordCnt > ((_PageSize * _BlockSize) + 1) ) {
			// 블럭 첫 페이지에서 점프 한 경우 블럭 계산 보정
			mRecordCnt -= mPageSize * (mBlockSize - 1);
		}

		// 블럭내 페이지 이동에 대한 보정
		if ( mIsNext == 0 && mJumpSize > 0 && mPageNo > 1 ) {
			// 블럭 내에서 11 -> 12 순으로 이동
			mRecordCnt -= mJumpSize * mPageSize;
		} else if ( mIsNext == 0 && mJumpSize < 0 && mPageNo > 1 ) {
			// 블럭 내에서 12 -> 11 순으로 이동
			mRecordCnt += Math.Abs(mJumpSize) * mPageSize;
		}


		int vPageNo, vJumpSize;
		int vStartNo = (mBlockSize * ((mPageNo-1) / mBlockSize)) + 1;
		int vLoopCnt = (mBlockSize * ((mPageNo-1) / mBlockSize)) + mBlockSize;

		// 마지막 블럭에서 페이지 번호 초과 (위에서 무조건 pBlockSize만큼 잡고 시작함)
		if ( vLoopCnt > (mPageNo + (mRecordCnt / mPageSize)) ) {
			vLoopCnt = (int) ((mPageNo - 1) + Math.Ceiling(Convert.ToDecimal(mRecordCnt) / mPageSize));
		}


		DataRow vNewRow;
		DataTable oPageList = new DataTable();
		const string vTmpPage = "{0},{1},{2},{3},{4},{5}|"; // pPageNo, pRowCnt, pJumpSize, pIsNext, pBaseMoveNo, pBaseMoveVo

		oPageList.Columns.Add("cComnd", typeof(string));
		oPageList.Columns.Add("cParam", typeof(string));
		oPageList.Columns.Add("cClass", typeof(string));
		oPageList.Columns.Add("cPagNo", typeof(string));

		// fnMovePage(pPageNo, pRowCnt, pLastNo, pLastVo, pJumpSize, pIsNext)
		// 이전 블럭
		if ( mPageNo > mBlockSize && mPageNo >= vStartNo ) {
			vPageNo		= vStartNo - 1;				// 시작 페이지 번호(21) - 1 = 20
			vJumpSize	= vStartNo - mPageNo - 1;	// 시작 페이지 번호(21) - 현재 이동한 페이지 번호(23) - 1 = -3

			vNewRow = oPageList.NewRow();
			vNewRow["cComnd"] = "home";
			vNewRow["cPagNo"] = "1";
			vNewRow["cParam"] = string.Format(vTmpPage, 1, 0, 1, 0, mDefaultNo, mDefaultVo);
			oPageList.Rows.Add(vNewRow);

			vNewRow = oPageList.NewRow();
			vNewRow["cComnd"] = "prev";
			vNewRow["cPagNo"] = "Prev";
			vNewRow["cParam"] = string.Format(vTmpPage, vPageNo, mRecordCnt, vJumpSize, -1, mFirstNo, mFirstVo);
			oPageList.Rows.Add(vNewRow);
		}


		for ( int i = vStartNo, n = 1; i <= vLoopCnt; ++i, ++n ) {
			vPageNo		= i;
			vJumpSize	= i - mPageNo;

			vNewRow = oPageList.NewRow();
			vNewRow["cComnd"] = "page";
			vNewRow["cPagNo"] = vPageNo.ToString("D");

			// 현재 페이지
			if ( mPageNo == i ) {
				vNewRow["cClass"] = "current";
				vNewRow["cParam"] = string.Format(vTmpPage, vPageNo, vPageNo, vPageNo, vPageNo, vPageNo, vPageNo);
			}
			// 최초 블럭에서 1페이지
			else if ( i == 1 ) {
				vNewRow["cParam"] = string.Format(vTmpPage, 1, 0, 1, 0, mDefaultNo, mDefaultVo);
			}
			// 현재 이전 페이지
			else if ( mPageNo > i ) {
				vNewRow["cParam"] = string.Format(vTmpPage, vPageNo, mRecordCnt, vJumpSize, 0, mFirstNo, mFirstVo);
			}
			// 현재 이후 페이지
			else {
				vNewRow["cParam"] = string.Format(vTmpPage, vPageNo, mRecordCnt, vJumpSize, 0, mLimitNo, mLimitVo);
			}

			oPageList.Rows.Add(vNewRow);
		}

		// 다음 블럭
		if ( (mPageSize*mBlockSize) < ((Math.Abs(vStartNo - mPageNo)*mPageSize) + mRecordCnt) ) {
			vPageNo		= vStartNo + mBlockSize;			// 시작 페이지 번호(21) + 블럭 크기(10) = 31
			vJumpSize	= vStartNo - mPageNo + mBlockSize;	// 시작 페이지 번호(21) - 현재 이동한 페이지 번호(23) + 블럭 크기(10) = 8

			vNewRow = oPageList.NewRow();
			vNewRow["cComnd"] = "next";
			vNewRow["cPagNo"] = "Next";
			vNewRow["cParam"] = string.Format(vTmpPage, vPageNo, mRecordCnt, vJumpSize, 1, mLimitNo, mLimitVo);
			oPageList.Rows.Add(vNewRow);
		}


		return oPageList;
	}
	#endregion Reply list
}
