/*! ******************************************************************************
 *
 * Pentaho Data Integration
 *
 * Copyright (C) 2002-2013 by Pentaho : http://www.pentaho.com
 *
 *******************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ******************************************************************************/

package com.hry.di.trans.steps.insertupdatevar;

import java.sql.PreparedStatement;

import org.pentaho.di.core.database.Database;
import org.pentaho.di.core.row.RowMetaInterface;
import org.pentaho.di.trans.step.BaseStepData;
import org.pentaho.di.trans.step.StepDataInterface;

/**
 * Stores data for the Insert/Update step.
 *
 * @author Matt
 * @since 24-jan-2005
 */
public class InsertUpdateVarData extends BaseStepData implements StepDataInterface {
	public Database db;

	/**
	 * 数据流key1在输入流中所对应的索引号,
	 */
	public int[] keynrs; // nr of keylookup -value in row...
	/**
	 * 数据流key2在输入流中所对应的索引号
	 */
	public int[] keynrs2; // nr of keylookup2-value in row...
	/**
	 * 更新流在输入流中所对应的索引号
	 */
	public int[] valuenrs; // Stream valuename nrs to prevent searches.

	public RowMetaInterface outputRowMeta;
	/**
	 * 数据库表名
	 */
	public String schemaTable;

	/**
	 * 查询PreparedStatement
	 */
	public PreparedStatement prepStatementLookup;
	/**
	 * 更新PreparedStatement
	 */
	public PreparedStatement prepStatementUpdate;

	/**
	 * 更新参数RowMeta
	 */
	public RowMetaInterface updateParameterRowMeta;
	/**
	 * 查询参数RowMeta
	 */
	public RowMetaInterface lookupParameterRowMeta;
	/**
	 * 查询结果RowMeta
	 */
	public RowMetaInterface lookupReturnRowMeta;
	/**
	 * 插入元数据
	 */
	public RowMetaInterface insertRowMeta;

	/**
	 * Default constructor.
	 */
	public InsertUpdateVarData() {
		super();

		db = null;
	}
}
