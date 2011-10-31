/*
 * Copyright (C) 2005-2011 Alfresco Software Limited.
 *
 * This file is part of Alfresco
 *
 * Alfresco is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Alfresco is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Alfresco. If not, see <http://www.gnu.org/licenses/>.
 */
package org.alfresco.util.schemacomp.model;

import java.util.ArrayList;
import java.util.List;

import org.alfresco.util.schemacomp.DbObjectVisitor;
import org.alfresco.util.schemacomp.DbProperty;
import org.alfresco.util.schemacomp.DiffContext;
import org.alfresco.util.schemacomp.Result.Strength;

/**
 * Primary key on a table.
 * 
 * @author Matt Ward
 */
public class PrimaryKey extends AbstractDbObject
{
    private final List<String> columnNames = new ArrayList<String>();


    public PrimaryKey(String name)
    {
        super(null, name);
    }
    
    /**
     * Constructor
     * @param table the parent table
     * @param name
     * @param columnNames
     */
    public PrimaryKey(Table table, String name, List<String> columnNames)
    {
        super(table, name);
        this.columnNames.addAll(columnNames);
    }

    /**
     * @return the columnNames
     */
    public List<String> getColumnNames()
    {
        return this.columnNames;
    }

    /**
     * @param columnNames the columnNames to set
     */
    public void setColumnNames(List<String> columnNames)
    {
        this.columnNames.clear();
        this.columnNames.addAll(columnNames);
    }

    @Override
    public int hashCode()
    {
        final int prime = 31;
        int result = super.hashCode();
        result = prime * result + ((this.columnNames == null) ? 0 : this.columnNames.hashCode());
        return result;
    }

    @Override
    public boolean equals(Object obj)
    {
        if (this == obj) return true;
        if (!super.equals(obj)) return false;
        if (getClass() != obj.getClass()) return false;
        PrimaryKey other = (PrimaryKey) obj;
        if (this.columnNames == null)
        {
            if (other.columnNames != null) return false;
        }
        else if (!this.columnNames.equals(other.columnNames)) return false;
        return true;
    }

    @Override
    protected void doDiff(DbObject right, DiffContext ctx, Strength strength)
    {
        PrimaryKey rightPK = (PrimaryKey) right;        
        comparisonUtils.compareSimpleCollections(
                    new DbProperty(this, "columnNames"),
                    new DbProperty(rightPK, "columnNames"),
                    ctx,
                    strength);
    }

    @Override
    public void accept(DbObjectVisitor visitor)
    {
        visitor.visit(this);
    }
}
