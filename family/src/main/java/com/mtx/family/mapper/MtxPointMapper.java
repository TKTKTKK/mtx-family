package com.mtx.family.mapper;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.github.miemiedev.mybatis.paginator.domain.PageList;
import com.mtx.common.base.BaseMapper;
import com.mtx.family.entity.MtxConsult;
import com.mtx.family.entity.MtxPoint;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MtxPointMapper extends BaseMapper<MtxPoint> {
    public PageList<MtxPoint> selectMtxPointList(@Param("mtxPoint") MtxPoint mtxPoint, PageBounds pageBounds);

    List<MtxPoint> queryPointForList(@Param("mtxPoint")MtxPoint point);

    public int queryCountConsumePoint(@Param("userid")String userid);
}
